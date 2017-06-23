Rails.application.routes.draw do

  # Session routes
  post 'sessions', :to => 'sessions#create'
  delete 'sessions/:id', :to => 'sessions#destroy', :as => 'logout'
  get 'sessions/new'

  # Delete confirm modal routes
  get 'musics/confirm_delete', :to => 'musics#confirm_delete', :as => 'delete_confirm_music'
  get 'movies/confirm_delete', :to => 'movies#confirm_delete', :as => 'delete_confirm_movie'
  get 'games/confirm_delete', :to => 'games#confirm_delete', :as => 'delete_confirm_game'
  get 'users/confirm_delete', :to => 'users#confirm_delete', :as => 'delete_confirm_user'

  # AJAX route for loading more content 
  get 'users/get_more', :to => 'users#get_more', :as => 'get_more'

  get 'welcome/Index'

  resources :musics
  resources :movies
  resources :games
  resources :users

  root 'welcome#Index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end