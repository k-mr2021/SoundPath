class PostMusic < ApplicationRecord
  
  # 音声ファイル投稿
  has_one_attached :audio
  mount_uploader :file, AudiofileUploader
  
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :subject, dependent: :destroy
  
  # 検索機能
  def self.search(keyword)
    if keyword.present?
      PostMusic.where(['title LIKE(?) OR body Like(?)', "%#{keyword}%", "%#{keyword}%"])
    else
      @post_musics = PostMusic.all
    end
  end
  
  # いいね
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end






