module MoviesHelper

	def find_trailer(movie)

		if !movie.trailer_url.nil?
			return movie.trailer_url.to_s
		else
			videos = Yt::Collections::Videos.new
			year = movie.year.to_s
			trailer = videos.where(q: movie.title+" trailer "+year).first
			if !trailer.nil?
				if movie.update_attribute(:trailer_url, trailer.id)
				else
					puts "Could not update database"
				end
				return trailer.id.to_s
			else
				return nil
			end
		end
	end
end