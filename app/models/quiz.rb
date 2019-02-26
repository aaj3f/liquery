class Quiz < ApplicationRecord
  belongs_to :user
  has_many :quiz_ratings
  has_many :drinks, through: :quiz_ratings

  def quiz_ratings_attributes=(quiz_ratings_attributes)
    quiz_ratings_attributes.values.each do |quiz_rating_attributes|
      quiz_rating = self.quiz_ratings.create(quiz_rating_attributes) unless quiz_rating_attributes[:score].blank?
    end
  end
end
