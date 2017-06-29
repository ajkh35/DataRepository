class Music < ApplicationRecord

	belongs_to :user

	validates :title, :presence => true
	validates_uniqueness_of :title, :scope => :user_id
	validates :artist, :presence => true
	validates :album, :presence => true
	validates :year, :presence => true

	def self.search(search)
		where("title LIKE '%#{search}%' OR artist LIKE '%#{search}%' OR album LIKE '%#{search}%' 
			OR year LIKE '%#{search}%'").all
	end

	def self.search_user(id,search)
		where("user_id LIKE '%#{id}%' AND title LIKE '%#{search}%' OR artist LIKE '%#{search}%' 
			OR album LIKE '%#{search}%' OR year LIKE '%#{search}%'").all
	end
end