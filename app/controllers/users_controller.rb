class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id])
    if @user && @user == current_user
      @liked_drinks, @recommended_drinks, @disliked_drinks = @user.liked_drinks, @user.recommended_drinks, @user.disliked_drinks
    end
  end

end
