class QuizController < ApplicationController
  def question_one
    @user = User.new
    @drinks = Drink.test_drinks
    @ratings = @drinks.map {|d| d.ratings.create }
  end

  def answer_one
    binding.pry
  end

  def question_two
  end

  def answer_two
  end

  def question_three
  end

  def answer_three
  end
end
