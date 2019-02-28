class Drink < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings
  has_many :quiz_ratings
  has_many :quizzes, through: :quiz_ratings
  has_many :measures
  has_many :ingredients, through: :measures
  has_many :flavor_profiles, through: :ingredients
  # accepts_nested_attributes_for :ingredients, reject_if: proc { |attributes| attributes['name'].blank? }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :preparation, presence: true
  validate :must_have_at_least_one_ingredient

  def self.test_drinks
    where("test_drink = 1")
  end

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

  def measures_attributes=(measures_attributes)
    measures_attributes.values.each do |measure_attributes|
      m = Measure.find_by_id(measure_attributes[:id]).update(measure_attributes)
    end
  end

  def list_ingredients
    self.ingredients.map {|i| i.name}.join(", ")
  end

  def article
    self.name.chars.first.match?(/[aeiou]/i) ? "an" : "a"
  end

end
