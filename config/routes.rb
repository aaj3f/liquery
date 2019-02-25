Rails.application.routes.draw do
  get 'quiz/question_one'
  post 'quiz/answer_one'
  get 'quiz/question_two'
  post 'quiz/answer_two'
  get 'quiz/question_three'
  post 'quiz/answer_three'

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
