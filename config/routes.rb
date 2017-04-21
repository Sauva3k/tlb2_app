Rails.application.routes.draw do

  resources :todo_lists
  #get 'sessions/new'
  get 'home_page/home' #will need to check how to replace
  get 'users/new'
  
  root 'home_page#home'
  
  #Rename user route
  get '/signup',     to: 'users#new'
  post '/signup',    to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :task_items
  resources :users do
	member do
	  get :wifis
	end 
	resources :task_items,        only: [:create, :destroy]
  end
  resources :wifis do
    member do
      get :users	
	end
  end 
  resources :account_activations, only: [:edit]
  resources :todo_lists do
    resources :todo_items do
	  member do
	    patch :complete
	  end
    end
  end
  resources :connections,         only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
