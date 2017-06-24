class MoviesController < ApplicationController
  
  before_action :authorize, :except => [:show,:show_trailer]
  respond_to :js, :html

  def index
  	@movies = Movie.where(user_id: get_current_user)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = get_current_user.id
    if @movie.save
      flash[:msg] = "Added movie"
    else
      render 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:msg] = "Updated movie"
    else
      render 'edit'
    end
  end

  def show
  	@movie = Movie.find(params[:id])
  end

  def show_trailer
    @movie = Movie.find(params[:id])
  end

  def destroy
  	@movie = Movie.find(params[:id])
  	@movie.destroy
    flash[:msg] = "Deleted movie"
  end

  def confirm_delete
    @movie = Movie.find(params[:id])
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :genre, :year)
  end
end