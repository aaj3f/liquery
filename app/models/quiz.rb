class Quiz < ApplicationRecord
  belongs_to :user
  has_many :quiz_ratings
  has_many :drinks, through: :quiz_ratings

  def quiz_ratings_attributes=(quiz_ratings_attributes)
    binding.pry
  end
end
