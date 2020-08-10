Rails.application.routes.draw do
  root 'products#index'
  resources :products do
    collection do
      get 'category/get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'category/get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
  end
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
