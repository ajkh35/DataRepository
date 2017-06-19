module MusicHelper

	def find_video(music)

		if !music.youtube_url.nil?
			return music.youtube_url.to_s
		else
			videos = Yt::Collections::Videos.new
			video = videos.where(q: music.title+music.artist,order: 'viewCount').first
			if !video.nil?
				if music.update_attribute(:youtube_url, video.id)
				else
					puts "Could not update database"
				end
				return video.id.to_s
			else
				return nil
			end
		end
	end
end