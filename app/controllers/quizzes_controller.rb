class QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_quiz, only: %i(show)

  def new
    @drinks = Drink.test_drinks
    @quiz = current_user.quizzes.build
    @drinks.each {|d| @quiz.quiz_ratings.build(drink_id: d.id) }
    @quiz_ratings = @quiz.quiz_ratings
    @flavor_profiles = FlavorProfile.all
  end

  def create
    @quiz = current_user.quizzes.create
    @quiz.update(quiz_params)
    @quiz.build_ratings_for_current_user
    @drink, @score, @quiz_info = @quiz.recommend_drink
    render json: { success: true, drink: @drink.attributes.merge( :score => @score, :quizInfo => @quiz_info )}
  end

  def show
    if @quiz.recommendation
      redirect_to drink_path(@quiz.drink_recommendation)
    else
      @quiz.build_ratings_for_current_user
      @drink, @score = @quiz.recommend_drink
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:flavor_profile_id, :quiz_ratings_attributes => [:drink_id, :score])
  end

  def find_quiz
    @quiz = current_user.quizzes.last
  end
end
