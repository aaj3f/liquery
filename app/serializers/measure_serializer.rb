class MeasureSerializer < ActiveModel::Serializer
  attributes :id, :size, :measurement_type
  belongs_to :ingredient
end
