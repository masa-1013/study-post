Rails.application.routes.draw do
  root to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/sign-in', to: 'users#new'
  post '/sign-in', to: 'users#create'
  post '/relationship', to: "relationships#create"
  delete '/relationship', to: "relationships#destroy"
  resources :users, only: [:index, :show, :edit, :update]
  resources :comments, only: [:create, :destroy]
  resources :studies
end
