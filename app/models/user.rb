class User < ApplicationRecord

	has_many :musics
	has_many :movies
	has_many :games

	attr_accessor :password_confirmation
	has_secure_password

	validates :email, :presence => true, :uniqueness => true
	validates :password, :presence => true,
						:confirmation => true,
						:length => {:within => 6..40},
                       	:on => :create
end