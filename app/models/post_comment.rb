class PostComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post_music
  has_many :notifications, dependent: :destroy
  
  
  private
  
  def create_notifications
    unless post_music.user.id == user.id
      Notification.create!(subject: self, user: post_music.user, action_type: Notification.action_types[:commented_to_own_post])
    end
  end
  
end









