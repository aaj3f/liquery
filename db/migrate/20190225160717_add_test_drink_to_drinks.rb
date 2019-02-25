class AddTestDrinkToDrinks < ActiveRecord::Migration[5.2]
  def change
    add_column :drinks, :test_drink, :boolean, default: false
  end
end
