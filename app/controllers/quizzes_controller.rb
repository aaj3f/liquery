class QuizzesController < ApplicationController
  before_action :authenticate_user!

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
    redirect_to quizzes_question_three_path
  end

  def question_three
    if current_user && current_user.ratings.present?
      @quiz = current_user.quizzes.last
    else
      redirect_to quizzes_results_path
    end
  end

  def answer_three
    @quiz = current_user.quizzes.last
    @quiz.update(answer_three_params)
    redirect_to quizzes_results_path
  end

  def results
    @user = current_user
    @quiz = current_user.quizzes.last
    if @quiz.recommendation
      redirect_to drink_path(@quiz.drink_recommendation)
    else
      @quiz.build_ratings_for_current_user
      @drink, @score = @quiz.recommend_drink
    end
  end

  private

  def answer_one_params
    params.require(:quiz).permit(:quiz_ratings_attributes => [:drink_id, :score])
  end

  def answer_two_params
    params.require(:quiz).permit(:flavor_profile_id)
  end

  def answer_three_params
    params.require(:quiz).permit(:use_previous_ratings)
  end
end
