# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'home/index'
  get 'activity', to: 'home#activity'
  resources :users, only: %i[index edit show update]
  resources :courses do
    get :purchased, :pending_review, :created, on: :collection
    resources :lessons
    resources :enrollments, only: %i[new create]
  end
  resources :enrollments do
    get :my_students, on: :collection
  end
end
