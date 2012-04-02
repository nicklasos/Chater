Chater::Application.routes.draw do

  devise_for :users
  get 'home/index'
  resources :private
  resources :rooms

  root :to => "home#index"
end
