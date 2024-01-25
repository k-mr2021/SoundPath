class Relationship < ApplicationRecord
  
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  has_many :notifications, as: :subject, dependent: :destroy
  
end


