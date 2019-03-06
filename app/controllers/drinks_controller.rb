class DrinksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?, only: %i(new create edit update destroy)

  def index
    @drinks = Drink.sort
    @header = "Drinks Index"
  end

  def new
    @drink = Drink.new
    @ingredients = Ingredient.all.sort_by {|i| i.name }
    @new_ingredients = 10.times.with_object([]) {|i, array| array << Ingredient.new}
  end

  def create
    @drink = Drink.new(drink_params)
    if @drink.save
      redirect_to edit_drink_path(@drink)
    else
      @ingredients = Ingredient.all.sort
      @new_ingredients = 10.times.with_object([]) {|i, array| array << Ingredient.new}
      render 'drinks/new'
    end
  end

  def show
    if params[:id]
      @drink = Drink.find_by_id(params[:id])
      @rating = @drink.ratings.create(user_id: current_user.id) unless current_user.liked_drinks.include?(@drink)
    else
      redirect_to root_path
    end
  end

  def edit
    @drink = Drink.find_by_id(params[:id])
  end

  def update
    @drink = Drink.find_by_id(params[:id])
    if @drink && @drink.update(measure_params)
      redirect_to drink_path(@drink)
    else
      render 'drinks/edit'
    end
  end

  private

  def measure_params
    params.require(:drink).permit(:measures_attributes => [:size, :measurement_type, :id, :ingredient_attributes => [:flavor_profile_id, :id]])
  end

  def drink_params
    params.require(:drink).permit(:name, :preparation, :image, ingredient_ids: [], ingredients_attributes: [:name])
  end

  def is_admin?
    return head(:forbidden) unless user_signed_in? && current_user.admin_access
  end

end
