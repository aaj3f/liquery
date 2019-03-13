module DrinksHelper

  def like_or_liked
    if current_user.liked_drinks.include?(@drink)
      "<button class=\"btn btn-success text-white\" disabled=\"disabled\">You\'ve liked this drink!</button>".html_safe
    else
      render partial: 'drinks/like', locals: { drink: @drink, current_user: current_user, rating: @rating }
    end
  end
end
