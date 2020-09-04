Rails.application.routes.draw do
  root 'products#index'
  resources :products do
    collection do
      get 'search'
      get 'category/get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'category/get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
    resources :purchase, only: [:show, :create] do
      member do
        post 'pay'
        get 'done'
        get 'fail'
        get 'card'
        post 'create'
      end
    end
  end
  resources :comments, only:[:create,:update,:destroy] do
    member do
      get 'restore'
    end
  end
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks',
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
  resources :cards, only: [:show, :new, :destroy] do
    collection do
      post 'pay'
      post 'show'
      post 'new'
    end
  end
end
