class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post_music
  
  # 重複していいねを押せないように制限
  validates :user_id, uniqueness: {scope: :post_music_id}
  
  private
  
  def create_notifications
    unless post_music.user.id == user.id
      Notification.create!(subject: self, user: post_music.user, action_type: Notification.action_types[:favorited_to_own_post])
    end
  end
  
end











