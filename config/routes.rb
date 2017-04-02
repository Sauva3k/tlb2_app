Rails.application.routes.draw do

  root 'home_page#home'
  get 'home_page/home'
  get 'users/new'
  get '/signup', to: 'users#new'
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
