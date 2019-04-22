Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :users, only: %i(show update) do
    member do
      get 'liked_drinks'
      get 'recommended_drinks'
    end
  end

  resources :quizzes, only: %i(show create new)

  get 'welcome/index'
  root 'welcome#index'

  get 'privacy', to: 'privacy#show'

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
