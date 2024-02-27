class PostMusic < ApplicationRecord

  # 音声ファイル投稿
  has_one_attached :audio
  mount_uploader :file, AudiofileUploader
  validates :file, format: { with: /\.(mp3|wav)\z/i, message: "はmp3またはwavファイルでなければなりません" }
  validates :title, presence: true

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

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
    if user.nil?
      false
    else
      favorites.exists?(user_id: user.id)
    end
  end

  #いいねの通知
  def create_notification_favorite!(current_user)
    #いいね済みか検証
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_music_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_music_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
        notification.save if notification.valid?
    end
  end

end

















