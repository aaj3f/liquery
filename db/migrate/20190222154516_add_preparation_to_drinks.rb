class AddPreparationToDrinks < ActiveRecord::Migration[5.2]
  def change
    add_column :drinks, :preparation, :string
  end
end
