Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy] do
    member do
      get :events
      get :favorites, to: "users#favorite_events"
      post :activation
    end
  end
  
  namespace :admin do
    resources :users, only: [:index]
  end
  
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  resources :events
  
  resources :favorites, only: [:create, :destroy]
  
  resources :comments, only: [:create, :destroy, :update]
end
