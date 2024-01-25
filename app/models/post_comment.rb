class PostComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post_music
  
  has_many :notifications, as: :subject, dependent: :destroy
  
end


