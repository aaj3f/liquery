class QuizRating < ApplicationRecord
  belongs_to :drink
  belongs_to :quiz

  validates :score, inclusion: { in: %w(nil 1 -1) }
end
