class AddRecommendedToRatings < ActiveRecord::Migration[5.2]
  def change
    add_column :ratings, :recommended, :boolean, default: false
  end
end
