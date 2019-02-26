class AddFlavorProfileIdToQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :flavor_profile_id, :integer
  end
end
