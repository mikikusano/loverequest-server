LoveRequest::Application.routes.draw do
  root to: "users#new"

  devise_for :users

  resources :users, only: [:index, :show, :new, :create]

  match 'travis/callback' => 'travis#callback'

  resources :questions, only: [:new, :create]
end


