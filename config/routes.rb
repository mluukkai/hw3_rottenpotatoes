Rottenpotatoes::Application.routes.draw do

  #resources :movies
  resources :movies do
    resources :reviews
    resources :comments
  end

  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')

  #match "/movie/rate" => "movies#rate"

  resources :withsamedirector

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  match "/" => "movies#index"

  match "/signin_anon" => "sessions#anon"
  match "/signin" => "sessions#signin"
  match "/signin_post" => "sessions#signin_post"
  match "/register" => "sessions#register"
  match "/register_post" => "sessions#register_post"
end

