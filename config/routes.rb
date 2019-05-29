Rails.application.routes.draw do
  devise_for :admins
  resources :items
  resources :roles
  root "home#index"
end
