class GamesController < ApplicationController
  
  before_action :authorize, :except => :show

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
      redirect_to game_path(@game)
      flash[:notice] = "Added Game"
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
      redirect_to game_path(@game)
      flash[:notice] = "Updated successfully"
    else
      render 'edit'
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end

  private
  def game_params
    params.require(:game).permit(:title, :creator, :year)
  end
end