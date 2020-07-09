Rails.application.routes.draw do
  root 'products#index'
  resources :products
  resources :users
  resources :destinations
  resources :images
  resources :brands
  resources :categorys
  resources :cards
end
