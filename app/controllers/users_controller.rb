class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id])
    if @user && @user == current_user
      
    end
  end

end
