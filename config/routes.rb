Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  root "posts#index"

  resources :posts do
    resources :comments, only: [:index, :new, :create]
  end

  resources :comments, only: [:show, :edit, :update, :destroy]

  resources :users, only: [:index, :show]
end
