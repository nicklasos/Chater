Chater::Application.routes.draw do

  devise_for :users
  get 'home/index'
  resources :private
  match '/rooms/create_message/:id' => 'rooms#create_message', :via => :post
  resources :rooms

  root :to => "home#index"
end
