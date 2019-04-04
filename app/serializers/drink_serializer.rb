class DrinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :preparation
  has_many :ingredients
  has_many :measures
end
