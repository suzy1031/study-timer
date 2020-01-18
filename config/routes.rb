Rails.application.routes.draw do

  devise_for :users
  root 'users#show'
  resources :start_days, only: [:new, :create]
  resources :count_times, only: [:new, :create, :edit, :update, :destroy]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
