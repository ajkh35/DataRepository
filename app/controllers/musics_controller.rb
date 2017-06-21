class MusicsController < ApplicationController

	before_action :authorize, :except => :show
	respond_to :js, :html

	def index
		@musics = Music.where(user_id: get_current_user)
	end

	def new
		@music = Music.new
	end

	def create
		@music = Music.new(music_params)
		@music.user_id = get_current_user.id
		if @music.save
			flash[:notice] = "Added song"
		else
			render 'new'
		end
	end

	def edit
		@music = Music.find(params[:id])
	end

	def update
		@music = Music.find(params[:id])
		if @music.update(music_params)
			flash[:notice] = "Updated song"
		else
			render 'edit'
		end		
	end

	def show
		@music = Music.find(params[:id])
	end

	def destroy
		@music = Music.find(params[:id])
		@music.destroy
		flash[:notice] = "Deleted song"
	end

	def confirm_delete
		@music = Music.find(params[:id])
	end

	private
	def music_params
		params.require(:music).permit(:title, :artist, :album, :year, :youtube_url)
	end
end