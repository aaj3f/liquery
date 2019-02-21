class CreateMeasures < ActiveRecord::Migration[5.2]
  def change
    create_table :measures do |t|
      t.belongs_to :drink, foreign_key: true
      t.belongs_to :ingredient, foreign_key: true
      t.float :size

      t.timestamps
    end
  end
end
