class QuizController < ApplicationController
  def question_one
    @user = User.new
    @drinks = Drink.test_drinks
  end

  def answer_one
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
