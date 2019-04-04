class QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_quiz, only: %i(question_two answer_two question_three answer_three results)

  def question_one
    @drinks = Drink.test_drinks
    @quiz = current_user.quizzes.build
    @drinks.each {|d| @quiz.quiz_ratings.build(drink_id: d.id) }
    @quiz_ratings = @quiz.quiz_ratings
    @flavor_profiles = FlavorProfile.all
  end

  def answer_one
    @quiz = current_user.quizzes.create
    @quiz.update(answer_one_params)
    @quiz.build_ratings_for_current_user
    @drink, @score, @quiz_info = @quiz.recommend_drink
    render json: { success: true, drink: @drink.attributes.merge( :score => @score, :quizInfo => @quiz_info )}
  end

  def question_two

  end

  def answer_two
    @quiz.update(answer_two_params)
    redirect_to quizzes_question_three_path
  end

  def question_three
    redirect_to quizzes_results_path unless current_user.ratings.present?
  end

  def answer_three
    @quiz.update(answer_three_params)
    redirect_to quizzes_results_path
  end

  def results
    if @quiz.recommendation
      redirect_to drink_path(@quiz.drink_recommendation)
    else
      @quiz.build_ratings_for_current_user
      @drink, @score = @quiz.recommend_drink
    end
  end

  private

  def answer_one_params
    params.require(:quiz).permit(:flavor_profile_id, :quiz_ratings_attributes => [:drink_id, :score])
  end

  def answer_two_params
    params.require(:quiz).permit(:flavor_profile_id)
  end

  def answer_three_params
    params.require(:quiz).permit(:use_previous_ratings)
  end

  def find_quiz
    @quiz = current_user.quizzes.last
  end
end
