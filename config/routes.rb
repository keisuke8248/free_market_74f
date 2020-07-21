Rails.application.routes.draw do
  root 'products#index'
  resources :products
  devise_for :users
  resources :users
  resources :destinations
  resources :images
  resources :brands
  resources :categorys
  resources :cards
end
