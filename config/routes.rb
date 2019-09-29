Rails.application.routes.draw do
  root to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/sign-in', to: 'users#new'
  post '/sign-in', to: 'users#create'
  resources :users, only: [:show, :edit, :update]
  resources :comments, only: [:create, :destroy]
  resources :studies
end
