class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post_music
  has_one :notification, as: :subject, dependent: :destroy
  
  after_create_commit :create_notifications
  
  # 重複していいねを押せないように制限
  validates :user_id, uniqueness: {scope: :post_music_id}
  
  private
  def create_notifications
    Notification.create(subject: self, user: self.post_music.user, action_type: :favorited_to_own_post)
  end
  
end





