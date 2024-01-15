class PostMusic < ApplicationRecord
  
  has_one_attached :audio
  mount_uploader :file, AudiofileUploader
  
end
