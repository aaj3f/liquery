class Measure < ApplicationRecord
  belongs_to :drink
  belongs_to :ingredient

  def ingredient_attributes=(ingredient_attributes)
    Ingredient.find_by_id(ingredient_attributes[:id]).update(flavor_profile_id: ingredient_attributes[:flavor_profile_id]) unless ingredient_attributes[:flavor_profile_id].blank?
  end
end
