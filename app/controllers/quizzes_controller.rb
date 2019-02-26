class QuizzesController < ApplicationController
  def question_one
    @user = current_user
    @drinks = Drink.test_drinks
    @quiz = @user.quizzes.build
    @drinks.each {|d| @quiz.quiz_ratings.build(drink_id: d.id) }
    @quiz_ratings = @quiz.quiz_ratings
  end

  def answer_one
    @user = current_user
    @quiz = @user.quizzes.create
    @quiz.update(answer_one_params)
    redirect_to quizzes_question_two_path
  end

  def question_two
    @quiz = current_user.quizzes.last
    
  end

  def answer_two
  end

  def question_three
  end

  def answer_three
  end

  private

  def answer_one_params
    params.require(:quiz).permit(:quiz_ratings_attributes => [:drink_id, :score])
  end
end
