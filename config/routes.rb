Rails.application.routes.draw do

  devise_for :users
  root 'start_days#index'
  resources :start_days
  resources :count_times
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
