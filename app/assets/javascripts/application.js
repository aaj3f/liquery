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
