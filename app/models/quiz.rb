class Quiz < ApplicationRecord
  belongs_to :user
  belongs_to :flavor_profile, optional: true
  has_many :quiz_ratings
  has_many :drinks, through: :quiz_ratings

  def quiz_ratings_attributes=(quiz_ratings_attributes)
    quiz_ratings_attributes.values.each do |quiz_rating_attributes|
      quiz_rating = self.quiz_ratings.create(quiz_rating_attributes) unless quiz_rating_attributes[:score].blank?
    end
  end

  def drink_recommendation
    Drink.where("drinks.id = ?", self.recommendation).first
  end

  def build_ratings_for_current_user
    self.quiz_ratings.each do |qr|
      self.user.ratings.where("ratings.drink_id = ?", qr.drink_id).first_or_create.update(score: qr.score, drink_id: qr.drink_id)
    end

  end

  def recommend_drink
    self.use_previous_ratings ? self.recommend_with_ratings : self.recommend_without_ratings
  end

  def recommend_with_ratings
    liked_drinks = self.user.liked_drinks
    disliked_drinks = self.user.disliked_drinks
    previously_recommended_drinks = self.user.recommended_drinks
    liked_ingredients = self.user.liked_ingredients
    disliked_ingredients = self.user.disliked_ingredients
    drinks_to_reject = liked_drinks + disliked_drinks + previously_recommended_drinks
    unrated_drinks = Drink.all.reject {|d| drinks_to_reject.include?(d) }
    drinks_of_chosen_profile = unrated_drinks.select {|d| d.flavor_profile_ids.include?(self.flavor_profile_id) }
    scored_results = drinks_of_chosen_profile.group_by {|d| (d.ingredients & liked_ingredients).size }
    score = scored_results.keys.max
    self.update(recommendation: scored_results[scored_results.keys.max].sample.id)
    self.user.ratings.where("ratings.drink_id = ?", self.recommendation).first_or_create.update(recommended: true, drink_id: self.recommendation)
    self.user.save
    drink = self.drink_recommendation
    [drink, score, quiz_info(drink, self)]
  end

  def recommend_without_ratings
    liked_drinks = Drink.joins(:quizzes).where(quizzes: { id: self.id }).group("drinks.id").having(quiz_ratings: { score: 1 })
    disliked_drinks = Drink.joins(:quizzes).where(quizzes: { id: self.id }).group("drinks.id").having(quiz_ratings: { score: -1 })
    liked_ingredients = Ingredient.joins(drinks: :quizzes).where(quizzes: { id: self.id }).group("ingredients.id").having(quiz_ratings: { score: 1 })
    disliked_ingredients = Ingredient.joins(drinks: :quizzes).where(quizzes: { id: self.id }).group("ingredients.id").having(quiz_ratings: { score: -1 })
    unrated_drinks = Drink.all.reject {|d| (liked_drinks + disliked_drinks).include?(d) }
    drinks_of_chosen_profile = unrated_drinks.select {|d| d.flavor_profile_ids.include?(self.flavor_profile_id) }
    scored_results = drinks_of_chosen_profile.group_by {|d| (d.ingredients & liked_ingredients).size }
    score = scored_results.keys.max
    self.update(recommendation: scored_results[scored_results.keys.max].sample.id)
    self.user.ratings.where("ratings.drink_id = ?", self.recommendation).first_or_create.update(recommended: true, drink_id: self.recommendation)
    self.user.save
    drink = self.drink_recommendation
    [drink, score, quiz_info(drink, self)]
  end

  def quiz_info(drink, quiz)
    ingredient = drink.ingredients.where("ingredients.flavor_profile_id = ?", quiz.flavor_profile_id).pluck(:name).sample.downcase
    flavor_profile = quiz.flavor_profile.name.downcase
    drink = drink.name
    "One of the components of this drink is #{ingredient}, which lends itself to the #{flavor_profile} palate you're looking for."
  end
end
