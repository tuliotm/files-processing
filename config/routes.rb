Rails.application.routes.draw do
  devise_for :users
  resources :documents, only: [:new, :create, :index]
  root to: 'documents#index'
end
