class AddRecommendationToQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :recommendation, :integer
  end
end
