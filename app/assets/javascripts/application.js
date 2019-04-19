// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require_tree .

class Drink {
  constructor(drinkInfo) {
    this.id = drinkInfo.id;
    this.name = drinkInfo.name;
    this.image = drinkInfo.image;
    this.preparation = drinkInfo.preparation;
    this.score = drinkInfo.score;
    this.quizInfo = drinkInfo.quizInfo;
  }

  nameWithArticle() {
    return (this.name.charAt(0).match(/[aeiou]/i) ? `an ${this.name}` : `a ${this.name}`)
  }

  resultsMessage() {
    if (this.score <= 1) {
      return "It's not perfect, but we were able to find a drink that matches a couple of the ingredients & drink palates you seem to like.";
    } else if (this.score <= 3) {
      return "This drink matches several of the ingredients you seem to enjoy. We're pretty sure you'll love it!";
    } else {
      return "Whooo doggy! This drink is right up your alley, with several ingredients in common with your preferred palate!";
    }
  }
}

// Establishes context for Handlebars template
const drinkTemplateWithContext = function(drink) {
  let drinksRow = document.querySelector('#drinks-row')
  let drinkCardTemplate = Handlebars.compile(document.querySelector('#drink-card-template').innerHTML)
  let context = {
    drink_id: drink.id,
    drink_image: drink.image,
    drink_name: drink.name,
    drink_ingredients: drink.ingredients.map((ingredient) => ingredient.name).join(', ')
  }
  drinksRow.innerHTML += drinkCardTemplate(context)
}

// Modularizes AJAX request/response code with variable path
function getDrinks(path) {
  return function() {
    $.get(path)
      .then(function(resp) {
        document.querySelector('#drinks-row').innerHTML = ""
        resp.forEach((drink) => drinkTemplateWithContext(drink))
      }).then(function() {
        $('.show-drink-modal').on('click', showDrinkModalFn)
      })
  }}

  // Uses closures of modularized code above to declare ajax request/response functions for drink collections
  const getAllDrinks = getDrinks("<%= drinks_path %>.json")
  const getLikedDrinks = getDrinks("<%= liked_drinks_user_path(current_user) %>")
  const getRecommendedDrinks = getDrinks("<%= recommended_drinks_user_path(current_user) %>")

  // Initiates AJAX request/response for show action & displays modal in DOM
  const showDrinkModalFn = function(event) {
    event.preventDefault();
    let drinkId = this.dataset.id // Button that triggered the modal
    let modal = $(this)

    $.get("/drinks/" + drinkId + ".json")
      .then(function(resp) {
        $('.modal-title').text(resp.name)
        $('.modal-ingredients').html(`<p><strong>Ingredients</strong></p><p><ul style="list-style-type:none;">
          ${resp.ingredients.map((i, index) => "<li>" + resp.measures[index].size + " " + resp.measures[index].measurement_type + " " + i.name + "</li>").join('')}
        </ul></p>`)
        $('.modal-preparation').html(`<p><strong>Preparation</strong></p><p>${resp.preparation}</p>`)
        $('#showModal').modal()
      })
    }
