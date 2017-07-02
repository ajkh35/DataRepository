class Document < ApplicationRecord

	belongs_to :user

	has_attached_file :doc

	validates_presence_of :title
	validates_uniqueness_of :title, :scope => :user_id
	validates_attachment :doc, :presence => true,
						:content_type => {content_type: %w(application/pdf application/msword 
							application/vnd.openxmlformats-officedocument.wordprocessingml.document
							application/vnd.oasis.opendocument.text)},
						:size => { :in => 0..1024.kilobytes }


	def self.search(search)
		where("title LIKE '%#{search}%'").all
	end

	def self.search_user(id,search)
		where("user_id LIKE '%#{id}%' AND title LIKE '%#{search}%'").all
	end
end