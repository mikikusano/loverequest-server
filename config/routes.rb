LoveRequest::Application.routes.draw do
  root to: "users#new"

  devise_for :users

  resources :users, only: [:index, :show, :new, :create]

  match 'travis/callback' => 'travis#callback'

  resources :questions, only: [:new, :create]
end


#== Route Map
# Generated on 03 Feb 2013 04:50
#
# user_omniauth_authorize      /users/auth/:provider(.:format)        devise/omniauth_callbacks#passthru {:provider=>/github/}
#  user_omniauth_callback      /users/auth/:action/callback(.:format) devise/omniauth_callbacks#(?-mix:github)
#                   users GET  /users(.:format)                       users#index
#                         POST /users(.:format)                       users#create
#                new_user GET  /users/new(.:format)                   users#new
#                    user GET  /users/:id(.:format)                   users#show
#         travis_callback      /travis/callback(.:format)             travis#callback
#               questions POST /questions(.:format)                   questions#create
#            new_question GET  /questions/new(.:format)               questions#new
