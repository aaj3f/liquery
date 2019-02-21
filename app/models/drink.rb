class Drink < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings
  has_many :measures
  has_many :ingredients, through: :measures
  has_many :flavor_profiles, through: :ingredients
end
