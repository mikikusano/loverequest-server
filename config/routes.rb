LoveRequest::Application.routes.draw do
  root to: "users#new"

  devise_for :users, controllers: { sessions: "sessions", omniauth_callbacks: "omniauth_callbacks" } do
    get '/users/sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :users, only: [:index, :show, :new]

  match 'travis/callback' => 'travis#callback'

  resources :questions, only: [:new, :create]
end


#== Route Map
# Generated on 03 Feb 2013 05:41
#
#    destroy_user_session GET  /users/sign_out(.:format)              devise/sessions#destroy
# user_omniauth_authorize      /users/auth/:provider(.:format)        omniauth_callbacks#passthru {:provider=>/github/}
#  user_omniauth_callback      /users/auth/:action/callback(.:format) omniauth_callbacks#(?-mix:github)
#                   users GET  /users(.:format)                       users#index
#                new_user GET  /users/new(.:format)                   users#new
#                    user GET  /users/:id(.:format)                   users#show
#         travis_callback      /travis/callback(.:format)             travis#callback
#               questions POST /questions(.:format)                   questions#create
#            new_question GET  /questions/new(.:format)               questions#new
