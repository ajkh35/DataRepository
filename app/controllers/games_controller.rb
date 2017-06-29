class GamesController < ApplicationController
  
  before_action :authorize, :except => [:show,:show_trailer]
  respond_to :js, :html

  def index
    @games = Game.where(user_id: get_current_user)
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = get_current_user.id
    if @game.save
      flash[:msg] = "Added Game"
    else
      render 'new'
    end  
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      flash[:msg] = "Updated game"
    else
      render 'edit'
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def show_trailer
    @game = Game.find(params[:id])
  end

  def search
    @games = Game.search_user(get_current_user.id,params[:search])
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    flash[:msg] = "Deleted game"
  end

  def confirm_delete
    @game = Game.find(params[:id])
  end

  private
  def game_params
    params.require(:game).permit(:title, :creator, :year)
  end
end