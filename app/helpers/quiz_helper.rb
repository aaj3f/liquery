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
      "We already have a sense for some of the drinks you tend to like. But if you wanna give us some new information or update your likes and dislikes, go ahead bebe!!"
    else
      "We're gonna get you a cocktail pronto, we just need to ask a few questions first so we can figure your drink out."
    end
  end

  def drink_article
    @drink.name.chars.first.match?(/[aeiou]/i) ? "an" : "a"
  end

end
