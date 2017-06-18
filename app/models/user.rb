class User < ApplicationRecord

	has_many :musics, dependent: :destroy
	has_many :movies, dependent: :destroy
	has_many :games, dependent: :destroy

	attr_accessor :password_confirmation
	has_secure_password

	has_attached_file :avatar, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}

	validates :email, :presence => true, :uniqueness => true
	validates :password, :presence => true,
						:confirmation => true,
						:length => {:within => 6..40},
                       	:on => :create
    validates :user_name, :presence => true, :uniqueness => true
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/                	
end