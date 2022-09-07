Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  root 'posts#index'

  resources :posts do
    resources :comments, except: [:index]
  end

  resources :users, only: [:index, :show] do
    resources :comments, only: [:index]
    resources :posts, only: [:index]
    resources :notifications, only: [:index]
  end

  resources :profiles, only: [:edit, :update]

  resources :friendships, only: [:index, :create, :update, :destroy]

  resources :likes, only: [:create, :destroy]

  resources :dislikes, only: [:create, :destroy]
end
