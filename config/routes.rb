# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "lists#index"

  resources :lists do
    member do
      resources :bookmarks, only: %i[new create destroy]
    end
  end
end
