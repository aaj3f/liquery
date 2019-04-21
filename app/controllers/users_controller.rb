class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
    redirect_to drinks_path
  end

  def update
    drink = Drink.find_by_id(like_drink_params[:drink_to_like])
    current_user.update(like_drink_params) if drink
    redirect_to drink_path(drink)
  end

  def liked_drinks
    @drinks = @user.liked_drinks.sort
    respond_to do |f|
      f.json { render json: @drinks }
    end
  end

  def recommended_drinks
    @drinks = @user.recommended_drinks.sort
    respond_to do |f|
      f.json { render json: @drinks }
    end
  end

  private

  def like_drink_params
    params.require(:user).permit(:drink_to_like)
  end

  def find_user
    @user = User.find_by_id(params[:id])
    return head(:forbidden) unless @user && @user == current_user
  end

end
