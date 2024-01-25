class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post_music
  
  has_one :notification, as: :subject, dependent: :destroy
  
  # 重複していいねを押せないように制限
  validates :user_id, uniqueness: {scope: :post_music_id}
  
end




