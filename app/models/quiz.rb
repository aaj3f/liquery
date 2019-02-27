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

  def build_ratings_for_current_user
    self.quiz_ratings.each do |qr|
      self.user.ratings.where("ratings.drink_id = ?", qr.drink_id).first_or_create(score: qr.score, drink_id: qr.drink_id)
    end
  end

  def recommend_drink
    binding.pry
    # self.use_previous_ratings ? self.recommend_with_ratings : self.recommend_without_ratings
  end

  def recommend_with_ratings
  end

  def recommend_without_ratings
    liked_drinks = Drink.joins(:quizzes).where(quizzes: { id: self.id }).group("drinks.id").having(quiz_ratings: { score: 1 }).pluck(:name)
    disliked_drinks = Drink.joins(:quizzes).where(quizzes: { id: self.id }).group("drinks.id").having(quiz_ratings: { score: -1 }).pluck(:name)
    liked_ingredients = Ingredient.joins(drinks: :quizzes).where(quizzes: { id: self.id }).group("ingredients.id").having(quiz_ratings: { score: 1 }).pluck(:name)
    disliked_ingredients = Ingredient.joins(drinks: :quizzes).where(quizzes: { id: self.id }).group("ingredients.id").having(quiz_ratings: { score: -1 }).pluck(:name)
    
  end
end
