module ApplicationHelper

	def nav_link_for_intermediaries(token)
		if token=='music'
			return musics_path
		elsif token=='movie'
			return movies_path
		elsif token=='game'
			return games_path
		else
		end	
	end
end