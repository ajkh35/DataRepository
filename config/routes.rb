Rails.application.routes.draw do

  # Session routes
  post 'sessions', :to => 'sessions#create'
  delete 'sessions/:id', :to => 'sessions#destroy', :as => 'logout'
  post 'sessions/create_from_nav', :to => 'sessions#create_from_nav', :as => 'login'
  get 'sessions/new'

  get 'welcome/Index'

  resources :musics
  resources :movies
  resources :games
  resources :users

  root 'welcome#Index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end