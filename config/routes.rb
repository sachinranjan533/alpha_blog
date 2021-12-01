Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  resources :articles
  get "signup", to: "users#new"
  #post "users", to: "users#create"
  resources :users,except: [:new]
  # added last 3 routes
  get "login", to: "sessions#new"
  post "login",to: "sessions#create"
  # using delete because it is somewhat related to delete a session 
  delete "logout",to: "sessions#destroy"
  # defining routes.
  resources :categories,except: [:destroy]
end
