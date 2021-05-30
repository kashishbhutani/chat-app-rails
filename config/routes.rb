# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  # Chat Room Routes
  resources :chat_rooms, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end

  # User Authentication
  devise_for :users

  # Root Path
  root 'home#index'
end
