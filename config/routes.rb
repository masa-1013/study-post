Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/sign-in', to: 'users#new'
  post '/sign-in', to: 'users#create'
  get 'users/edit'
  post 'users/edit', to: 'users#update'
  get 'users/show'
  root to: 'users#new'
  resources :studies
end
