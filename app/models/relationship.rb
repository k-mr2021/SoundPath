class Relationship < ApplicationRecord
  
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  has_one :notifications, as: :subject, dependent: :destroy
  
  def create_notifications
    Notification.create(subject: self, user: followed, action_type: :followed_me)
  end
  
end



