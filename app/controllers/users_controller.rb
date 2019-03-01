class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show

  end

  def update
    drink_id = current_user.add_liked_drink(params)
    redirect_to drink_path(drink_id)
  end

  def liked_drinks
    @drinks = @user.liked_drinks.sort
    @header = "Drinks You Like"
  end

  def recommended_drinks
    @drinks = @user.recommended_drinks.sort
    @header = "Drinks We Recommend"
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
    return head(:forbidden) unless @user && @user == current_user
  end

end
