Rails.application.routes.draw do
  get 'quiz/question_one'
  get 'quiz/answer_one'
  get 'quiz/question_two'
  get 'quiz/answer_two'
  get 'quiz/question_three'
  get 'quiz/answer_three'
  get 'welcome/index'
  root 'welcome#index'

  resources :drinks do
    resources :measures, only: %i(edit update)
  end
  devise_for :users
  resources :admin do
    resources :drinks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
