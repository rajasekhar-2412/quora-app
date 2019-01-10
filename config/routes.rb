Rails.application.routes.draw do

  devise_for :views
  devise_for :users
  resources :comments
  root "questions#index"

  resources :questions do
    resources :favorites, only: [:create, :destroy, :update]
    resources :votes, only: [:create, :update, :destroy]
    resources :answers
    post :search, on: :collection
  end

  # get "/about_us"           => "home#about"
  # get "/faq"                => "faq#index"
  # get "/help"               => "help#index"

  # get "/questions"          => "questions#index"

  # post "/questions"         => "questions#create"
  # get "/questions/new"      => "questions#new"
  # get "/questions/:id"      => "questions#show"
  # get "/questions/:id/edit" => "questions#edit"
  # match "/questions/:id"    => "questions#update", via: [:put, :patch]
  # delete "/questions/:id"   => "questions#destroy"


end
