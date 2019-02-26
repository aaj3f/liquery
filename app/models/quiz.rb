class Quiz < ApplicationRecord
  belongs_to :user
  has_many :ratings
  has_many :drinks, through: :ratings
end
