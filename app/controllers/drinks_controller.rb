class DrinksController < ApplicationController
  before_action :is_admin?, only: %i(new create edit update)

  def new

  end

  private

  def is_admin?
    return head(:forbidden) unless logged_in? && current_user.admin_access
  end
end
