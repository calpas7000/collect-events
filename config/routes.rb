Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [:new, :create] do
    member do
      get :events
      get :favorites, to: "users#favorite_events"
    end
  end
  
  resources :events, only: [:index,:create, :destroy, :show, :new]
  
  resources :favorites, only: [:create, :destroy]
end
