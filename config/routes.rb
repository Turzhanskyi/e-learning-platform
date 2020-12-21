# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'home/index'
  get 'home/activity'
  resources :courses
  resources :users, only: [:index]
end
