module DrinksHelper

  def like_or_liked
    if current_user.liked_drinks.include?(@drink)
      "<button class=\"btn btn-success text-white\" disabled=\"disabled\">You\'ve liked this drink!</button>".html_safe
    else
      form_for current_user do |f|
        f.submit "Like this Drink?", name: "#{@drink.id}", class: "btn btn-primary text-white"
      end
    end
  end
end
