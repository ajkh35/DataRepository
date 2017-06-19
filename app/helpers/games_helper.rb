module GamesHelper

	def find_trailer(game)

		if !game.trailer_url.nil?
			return game.trailer_url.to_s
		else	
			year = game.year.to_s
			videos = Yt::Collections::Videos.new
			trailer = videos.where(q: game.title+" trailer"+year,owner_name: game.creator).first
			if !trailer.nil?	
				if game.update_attribute(:trailer_url, trailer.id)
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