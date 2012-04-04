Chater::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :users
  get 'home/index'
  match '/private/history/:id' => 'private#history'
  resources :private
  match '/rooms/create_message/:id' => 'rooms#create_message', :via => :post
  match '/rooms/history/:id' => 'rooms#history'
  resources :rooms

  root :to => "home#index"
end
