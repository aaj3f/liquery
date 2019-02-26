class WelcomeController < ApplicationController

  def index
    if user_signed_in? && current_user.ratings.empty?
      redirect_to quizzes_question_one_path
    elsif user_signed_in?
      redirect_to drinks_path
    end
  end

end
