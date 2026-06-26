Rails.application.routes.draw do
  devise_for :users
  devise_for :views
  resources :friends
  get "home/about"
  #root "home#index"
  root "friends#index"

  get "up" => "rails/health#show", as: :rails_health_check

end
