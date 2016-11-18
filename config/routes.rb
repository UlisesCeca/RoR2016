Rails.application.routes.draw do
  get "logout" => "session#destroy", :as => "logout"
  get "login" => "session#new", :as => "login"
  post "login" => "session#create"
  get "signup" => "authors#new", :as => "signup"

  resources :authors
  resources :sessions
  resources :books

  root :to => "books#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
