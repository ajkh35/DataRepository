class WelcomeController < ApplicationController
  
  respond_to :js, :html

  def Index
  	@songs = Music.order(:created_at)
  	@movies = Movie.order(:created_at)
  	@games = Game.order(:created_at)
  end

  def dark_theme
  end

  def search
  	@songs = Music.search(params[:search])
  	@movies = Movie.search(params[:search])
  	@games = Game.search(params[:search])
  end
end