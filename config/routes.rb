# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'home#index'
  get 'home/index'
  get 'activity', to: 'home#activity'
  get 'analytics', to: 'home#analytics'

  resources :enrollments do
    get :my, on: :collection
  end

  resources :courses do
    get :learning, :pending_review, :teaching, :unapproved, on: :collection
    member do
      get :analytics
      patch :approve
      patch :unapprove
    end
    resources :lessons do
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: %i[new create]
  end
  resources :youtube, only: :show

  resources :users, only: %i[index edit show update]

  namespace :charts do
    get 'users_per_day'
    get 'enrollments_per_day'
    get 'course_popularity'
    get 'money_makers'
  end
end
