class Ingredient < ApplicationRecord
  belongs_to :flavor_profile
  has_many :measures
  has_many :drinks, through: :measures
end
