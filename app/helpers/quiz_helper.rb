module QuizHelper

  def modal_header
    if current_user.ratings.present?
      'Yasss boo!!<br>Welcome back!!'.sanitize
    else
      'Heyo sis!<br>You look thirsty!'.sanitize
    end
  end

  def modal_text
    if current_user.ratings.present?
      'We already have a sense for some of the drinks you tend to like.<br>But if you wanna give us some new information or update your likes and dislikes<br>go ahead bebe!!'.sanitize
    else
      'We\'re gonna get you a cocktail pronto,<br>we just need to ask a few questions first<br>so we can figure your drink out.'.sanitize
    end
  end

  def drink_article
    @drink.name.chars.first.match?(/[aeiou]/i) ? "an" : "a"
  end

end
