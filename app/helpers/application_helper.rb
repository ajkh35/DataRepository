module ApplicationHelper

	# def nav_link_for_intermediaries(token)
	# 	if token=='music' || current_page?(search_music_path)
	# 		return "controller: musics,action: index"
	# 	elsif token=='movie' || current_page?(search_movies_path)
	# 		return "controller: movies,action: index"
	# 	elsif token=='game' || current_page?(search_games_path)
	# 		return "controller: games,action: index"
	# 	else
	# 	end	
	# end

	def go_back
		url = request.original_url
		path = url.split('/search')[0]
		return path.to_s
	end
end