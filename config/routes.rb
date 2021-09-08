Rails.application.routes.draw do
  devise_for :users
  resources :courses
  resources :users, except: [:delete]
  root 'home#index'
  get 'home/activity'
  get 'static_pages/privacy_policy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
