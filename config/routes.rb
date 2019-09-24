Rails.application.routes.draw do
  get '/sign-in', to: 'users#new'
  post '/sign-in', to: 'users#create'
  get 'users/edit'
  post 'users/edit', to: 'users#update'
  get 'users/show'
  root to: 'studies#index'
  resources :studies
end
