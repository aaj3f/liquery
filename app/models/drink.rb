class Drink < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings
  has_many :quiz_ratings
  has_many :quizzes, through: :quiz_ratings
  has_many :measures
  has_many :ingredients, through: :measures
  has_many :flavor_profiles, through: :ingredients
  # accepts_nested_attributes_for :ingredients, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :measures

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :preparation, presence: true
  validate :must_have_at_least_one_ingredient

  def self.test_drinks
    where("test_drink = TRUE")
  end

  def self.sort
    order("drinks.name")
  end

  # def self.bitter, self.bright, etc. --> scope methods would allow you to chain together
  #
  # end


  def must_have_at_least_one_ingredient
    errors.add(:ingredients, "must exist!") if self.ingredients.empty?
  end

  def ingredients_attributes=(ingredients_attributes)
    ingredients_attributes.values.each do |ingredient_attributes|
      unless Ingredient.find_by(name: ingredient_attributes[:name]) || ingredient_attributes[:name].blank?
        ingredient = Ingredient.create(name: ingredient_attributes[:name])
        ingredients << ingredient
      end
    end
  end

  def list_ingredients
    self.ingredients.map {|i| i.name}.join(", ")
  end

  def correct_article
    self.name.chars.first.match?(/[aeiou]/i) ? "an" : "a"
  end

  def results_message(score)
    if score <= 1
      "It's not perfect, but we were able to find a drink that matches a couple of the ingredients & drink palates you seem to like."
    elsif score <= 3
      "This drink matches several of the ingredients you seem to enjoy. We're pretty sure you'll love it!"
    else
      "Whooo doggy! This drink is right up your alley, with several ingredients in common with your preferred palate!"
    end
  end

end
