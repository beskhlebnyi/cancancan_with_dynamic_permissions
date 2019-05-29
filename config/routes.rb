Rails.application.routes.draw do
  devise_for :admins
  resources :items
  resources :roles
  resources :permissions
  root "home#index"
end
