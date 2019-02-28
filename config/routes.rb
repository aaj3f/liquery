Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  get 'quizzes/question_one'
  post 'quizzes/answer_one'
  get 'quizzes/question_two'
  patch 'quizzes/answer_two'
  get 'quizzes/question_three'
  patch 'quizzes/answer_three'
  get 'quizzes/results'

  get 'welcome/index'
  root 'welcome#index'

  resources :drinks do
    resources :measures, only: %i(edit update)
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
