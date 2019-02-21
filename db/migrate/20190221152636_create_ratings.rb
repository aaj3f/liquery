class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :drink, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
