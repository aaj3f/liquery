class WelcomeController < ApplicationController

  def index
    if user_signed_in? && current_user.ratings.empty?
      redirect_to new_quiz_path
    elsif user_signed_in?
      redirect_to user_path(current_user)
    end
  end

end
