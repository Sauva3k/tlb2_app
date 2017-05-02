Rails.application.routes.draw do

  #get 'home_page/home' #will need to check how to replace
  #get 'users/new'
  
  root 'home_page#home'
  
  #Rename user routes
  get '/signup',     to: 'users#new'
  post '/signup',    to: 'users#create'
  
  #Rename login routes
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get '/connection', to: 'connections#new'
  
  post '/confirm_key', to: 'wifis#confirm_key'
    
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
	collection do
	  get :confirm_key
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
  resources :todo_lists
  
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
