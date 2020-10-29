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
  
  get "events/:year/:month", to: "events#index"
  resources :events, only: [:index,:create, :destroy, :show, :new]

end
