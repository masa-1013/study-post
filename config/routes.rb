Rails.application.routes.draw do
  root to: 'studys#index'
  resources :studys
end
