Rails.application.routes.draw do
  root 'homepage#index'
  get '/feeds' => 'feeds#index'

  # USERS
  resources :users, only: [:create]

  # SESSIONS
  resources :sessions, only: [:create]
  get '/authenticated', to: 'sessions#authenticated'
  delete '/sessions', to: 'sessions#destroy'

  # TWEETS
  resources :tweets, only: [:create, :index]  # Add this line for creating tweets
  get '/users/:username/tweets', to: 'tweets#index_by_user'
  resources :tweets, only: [:create, :destroy]  # Include :destroy action
  delete '/tweets/:id', to: 'tweets#destroy'

  # Redirect all other paths to index page, which will be taken over by AngularJS
  get '*path' => 'homepage#index'
end
