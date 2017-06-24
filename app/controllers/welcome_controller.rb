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
  	@songs = Music.where(title: params[:search])
  	@movies = Movie.where(title: params[:search])
  	@games = Game.where(title: params[:search])
  end
end