class CreateQuizRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_ratings do |t|
      t.belongs_to :drink, foreign_key: true
      t.belongs_to :quiz, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
