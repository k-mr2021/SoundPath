class PostComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post_music
  
  has_one :notifications, as: :subject, dependent: :destroy
  
  after_create_commit :create_notifications
  
  private
  def create_notifications
    Notification.create(subject: self, user: post_music.user, action_type: :commented_to_own_post)
  end
  
end




