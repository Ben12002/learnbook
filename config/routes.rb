Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  root "posts#index"

  resources :posts do
    resources :comments, only: [:new, :create, :edit, :update, :show]
  end

  resources :comments, only: [:destroy]

  resources :users, only: [:index, :show] do
    resources :comments, only: [:index]
    resources :posts, only: [:index]
  end

  resources :likes, only: [:create, :destroy]

  resources :dislikes, only: [:create, :destroy]
end
