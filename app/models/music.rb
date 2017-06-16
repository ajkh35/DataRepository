class Music < ApplicationRecord

	belongs_to :user

	validates :title, :uniqueness => true, :presence => true
	validates :artist, :presence => true
	validates :album, :presence => true
	validates :year, :presence => true
end