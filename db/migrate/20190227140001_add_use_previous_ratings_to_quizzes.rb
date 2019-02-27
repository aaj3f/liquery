class AddUsePreviousRatingsToQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :use_previous_ratings, :boolean, default: false
  end
end
