Rails.application.routes.draw do
  devise_for :users, skip: :registrations

  root "users#index"

  resources :users, only: [ :index, :show,:new, :create, :edit, :update]
  resources :chats, only: [ :index, :show,:new, :create, :edit, :update]
  resources :messages, only: [ :index, :show,:new, :create, :edit, :update]
end
