# frozen_string_literal: true

Rails
  .application
  .routes
  .draw do
    resources :notifications, only: [:index] do
      member { patch :mark_as_read }
    end

    resources :users, only: %i[index show] do
      get 'bets', on: :member
    end

    resources :participations
    resources :bets do
      member { post 'resolve' }
    end

    get 'up' => 'rails/health#show', :as => :rails_health_check

    root 'home#index'

    # Authentication routes
    get '/auth/:provider/callback', to: 'sessions#create'
    get '/auth/failure', to: 'sessions#failure'
    get '/logout' => 'sessions#destroy'

    match '*unmatched', to: 'errors#not_found', via: :all
  end
