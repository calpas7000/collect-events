Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [:new, :create] do
    member do
      get :events
    end
  end
  
  resources :events, only: [:create, :destroy, :show, :new]

  get "events/:year/:month", to: "events#index"
end
