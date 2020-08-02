Rails.application.routes.draw do
  root 'products#index'
  resources :products
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :destinations, controllers: {
    sessions:      'destinations/sessions',
    passwords:     'destinations/passwords',
    registrations: 'destinations/registrations'
  }
  resources :users
  resources :destinations
  resources :images
  resources :brands
  resources :categorys
  resources :cards
end
