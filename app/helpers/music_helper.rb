module MusicHelper

	def check_attributes(music)
		music.attributes.each do |attr|
			return false if music[attr].nil?
		end
	end
end