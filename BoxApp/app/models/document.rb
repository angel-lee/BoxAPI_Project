class Document < ActiveRecord::Base
	mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader
	validates :name, presence: true # Make sure the owner's name is present
end