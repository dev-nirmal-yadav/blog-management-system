# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  devise_for :users, only: :sessions
  devise_scope :user do
    get '/register', to: 'users/registrations#new', as: :new_user_register
    post '/register', to: 'users/registrations#create'
  end
  resources :users, only: %i[edit update]
  resources :posts do
    delete :delete_main_image_attachment, on: :member
    put :publish, on: :member
  end
end
