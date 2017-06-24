Rails.application.routes.draw do

  # Session routes
  post 'sessions', :to => 'sessions#create'
  delete 'sessions/:id', :to => 'sessions#destroy', :as => 'logout'
  get 'sessions/new'

  # Show trailer routes
  get 'show_video/:id', :to => 'musics#show_video', :as => 'show_video'
  get 'movies/show_trailer/:id', :to => 'movies#show_trailer', :as => 'show_movie_trailer'
  get 'games/show_trailer/:id', :to => 'games#show_trailer', :as => 'show_game_trailer'

  # Delete confirm modal routes
  get 'musics/confirm_delete', :to => 'musics#confirm_delete', :as => 'delete_confirm_music'
  get 'movies/confirm_delete', :to => 'movies#confirm_delete', :as => 'delete_confirm_movie'
  get 'games/confirm_delete', :to => 'games#confirm_delete', :as => 'delete_confirm_game'
  get 'users/confirm_delete', :to => 'users#confirm_delete', :as => 'delete_confirm_user'

  # AJAX route for loading more content 
  get 'users/get_more', :to => 'users#get_more', :as => 'get_more'

  # Search routes
  post 'musics/search', :to => 'musics#search', :as => 'search_music'
  post 'movies/search', :to => 'movies#search', :as => 'search_movies'
  post 'games/search', :to => 'games#search', :as => 'search_games'
  post 'welcome/search', :to => 'welcome#search', :as => 'home_search'

  get 'welcome/Index'

  resources :musics
  resources :movies
  resources :games
  resources :users

  root 'welcome#Index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end