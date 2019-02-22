Rails.application.routes.draw do
  resources :drinks, only: %i(index show)
  devise_for :users
  resources :admin do
    resources :drinks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
