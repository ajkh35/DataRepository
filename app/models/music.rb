class Music < ApplicationRecord

	belongs_to :user

	validates :title, :presence => true
	validates_uniqueness_of :title, :scope => :user_id
	validates :artist, :presence => true
	validates :album, :presence => true
	validates :year, :presence => true
end