class MusicsController < ApplicationController

	before_action :authorize, :except => :show

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
			redirect_to music_path(@music)
			flash[:notice] = "Added Successfully."
		else
			render 'new'
			flash[:alert] = "Save Unsuccessful."
		end
	end

	def edit
		@music = Music.find(params[:id])
	end

	def update
		@music = Music.find(params[:id])
		if @music.update(music_params)
			redirect_to music_path(@music)
			flash[:notice] = "Updated Successfully."
		else
			render 'edit'
			flash[:alert] = "Could not update."
		end		
	end

	def show
		@music = Music.find(params[:id])
	end

	def destroy
		@music = Music.find(params[:id])
		@music.destroy
		redirect_to musics_path
		flash[:notice] = "Deleted Successfully."
	end

	private
	def music_params
		params.require(:music).permit(:title, :artist, :album, :year, :youtube_url)
	end
end