class Movie < ApplicationRecord

	belongs_to :user

	validates :title, :uniqueness => true, :presence => true
	validates :genre, :presence => true
	validates :year, :presence => true
end