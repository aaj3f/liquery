class User < ApplicationRecord
  has_many :quizzes
  has_many :ratings
  has_many :quiz_ratings, through: :quizzes
  has_many :drinks, through: :ratings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def ratings_attributes=(ratings_attributes)
    binding.pry
  end

  def liked_drinks
    Drink.joins(:users).where(users: { id: self.id }).group("drinks.id").having(ratings: { score: 1 })
  end

  def disliked_drinks
    Drink.joins(:users).where(users: { id: self.id }).group("drinks.id").having(ratings: { score: -1 })
  end

  def recommended_drinks
    Drink.joins(:users).where(users: { id: self.id }).group("drinks.id").having(ratings: { recommended: true })
  end

  def liked_ingredients
    Ingredient.joins(drinks: :users).where(users: { id: self.id }).group("ingredients.id").having(ratings: { score: 1 })
  end

  def disliked_ingredients
    Ingredient.joins(drinks: :users).where(users: { id: self.id }).group("ingredients.id").having(ratings: { score: -1 })
  end
end
