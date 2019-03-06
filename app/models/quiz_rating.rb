class QuizRating < ApplicationRecord
  belongs_to :drink
  belongs_to :quiz
end
