# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  concern :votable do
    member do
      patch :voted_for, :voted_against
      delete :revote
    end
  end

  root to: 'questions#index'

  resources :questions, concerns: :votable do
    resources :answers, concerns: :votable, shallow: true, only: %i[create update destroy] do
      patch :best, on: :member
    end
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :rewards, only: :index
end
