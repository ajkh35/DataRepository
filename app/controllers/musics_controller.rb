class MusicsController < ApplicationController

	before_action :authorize, :except => [:show,:show_video]
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
			flash[:msg] = "Added song"
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
			flash[:msg] = "Updated song"
		else
			render 'edit'
		end		
	end

	def show
		@music = Music.find(params[:id])
	end

	def show_video
		@music = Music.find(params[:id])
	end

	def destroy
		@music = Music.find(params[:id])
		@music.destroy
		flash[:msg] = "Deleted song"
	end

	def confirm_delete
		@music = Music.find(params[:id])
	end

	def search
		@songs = Music.search_user(get_current_user.id,params[:search])
	end

	private
	def music_params
		params.require(:music).permit(:title, :artist, :album, :year, :youtube_url)
	end

	def get_token(token)
		if token == 'music_title'
			return 'title'
		else
			return 'year'
		end
	end
end