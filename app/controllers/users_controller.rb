class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show

  end

  def liked_drinks
    @drinks = @user.liked_drinks
  end

  def recommended_drinks
    @drinks = @user.recommended_drinks
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
    return head(:forbidden) unless @user && @user == current_user
  end

end
