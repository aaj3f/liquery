class DrinksController < ApplicationController
  before_action :is_admin?, only: %i(new create edit update)

  def new
    @drink = Drink.new
    @ingredients = Ingredient.all.sort
    @new_ingredients = 5.times.with_object([]) {|i, array| array << Ingredient.new}
  end

  def create
    @drink = Drink.new(drink_params)
    if @drink.save
      redirect_to edit_drink_path(@drink)
    else
      @ingredients = Ingredient.all.sort
      @new_ingredients = 5.times.with_object([]) {|i, array| array << Ingredient.new}
      render 'drinks/new'
    end
    # params = {
    #   'drink' => {
    #     'name' => "A NAME",
    #     'measures' => {
    #       'bourbon' => 1.5,
    #       'sweet vermouth' => 1.0,
    #       'bitters' => 0.0
    #     },
    #     'preparation' => "A STRING"
    #   }
    # }
  end

  def show

  end

  def edit
    @drink = Drink.find_by_id(params[:id])
  end

  private

  def drink_params
    params.require(:drink).permit(:name, :preparation, ingredient_ids: [], ingredients_attributes: [:name])
  end

  def is_admin?
    return head(:forbidden) unless user_signed_in? && current_user.admin_access
  end
end
