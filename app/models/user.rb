class User < ApplicationRecord
  has_many :quizzes
  has_many :ratings
  has_many :ratings, through: :quizzes
  has_many :drinks, through: :ratings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def ratings_attributes=(ratings_attributes)
    binding.pry
  end
end
