class FlavorProfile < ApplicationRecord
  has_many :ingredients
  has_many :drinks, through: :ingredients
  has_many :quizzes

  validates :name, presence: true
end
