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
    binding.pry
    self.quiz_ratings.each do |qr|
      self.user.ratings.where("ratings.drink_id = ?", qr.drink_id).first_or_create(score: qr.score, drink_id: qr.drink_id)
    end
    binding.pry
  end
end
