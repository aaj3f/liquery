module QuizHelper

  def modal_header
    if current_user.ratings.present?
      "Yasss boo!! Welcome back!!"
    else
      "Heyo sis! You look thirsty!"
    end
  end

  def modal_text
    if current_user.ratings.present?
      "We already have a sense for some of the drinks you tend to like.\nBut if you wanna give us some new information\nor update your likes and dislikes, go ahead bebe!!"
    else
      "We're gonna get you a cocktail right quick,\nWe just need to ask a few questions first\nso we can figure your drink out."
    end
  end

  def drink_article
    @drink.name.chars.first.match?(/[aeiou]/i) ? "an" : "a"
  end

  def quiz_info
    ingredient = @drink.ingredients.where("ingredients.flavor_profile_id = ?", @quiz.flavor_profile_id).pluck(:name).sample.downcase
    flavor_profile = @quiz.flavor_profile.name.downcase
    drink = @drink.name
    "One of the components of #{drink_article} #{drink} is #{ingredient}, which lends itself to the #{flavor_profile} palate you're looking for."
  end
end
