Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :users, only: %i(show update) do
    member do
      get 'liked_drinks'
      get 'recommended_drinks'
    end
  end

  get 'quizzes/question_one'
  post 'quizzes/answer_one'
  get 'quizzes/question_two'
  patch 'quizzes/answer_two'
  get 'quizzes/question_three'
  patch 'quizzes/answer_three'
  get 'quizzes/results'

  get 'welcome/index'
  root 'welcome#index'

  # resources :admin do
  #   resources :drinks, only %i(new)
  # end

  resources :ratings, only: %i(create update)

  resources :drinks do
    resources :measures, only: %i(edit update)
    patch 'users/:user_id', to: 'users#update', as: 'user_update'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
