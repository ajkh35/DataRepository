class Game < ApplicationRecord

	belongs_to :user

	validates :title, :presence => true
	validates_uniqueness_of :title, :scope => :user_id
	validates :creator, :presence => true
	validates :year, :presence => true	
end