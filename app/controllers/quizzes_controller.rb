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
    @flavor_profiles = FlavorProfile.all
  end

  def answer_two
    @user = current_user
    @quiz = current_user.quizzes.last
    @quiz.update(answer_two_params)
    redirect_to quizzes_results_path
  end

  def question_three
  end

  def answer_three
  end

  def results
    @user = current_user
    @quiz = current_user.quizzes.last
    @quiz.build_ratings_for_current_user
  end

  private

  def answer_one_params
    params.require(:quiz).permit(:quiz_ratings_attributes => [:drink_id, :score])
  end

  def answer_two_params
    params.require(:quiz).permit(:flavor_profile_id)
  end
end
