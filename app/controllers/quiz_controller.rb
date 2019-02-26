class QuizzesController < ApplicationController
  def question_one
    @user = current_user
    @drinks = Drink.test_drinks

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
