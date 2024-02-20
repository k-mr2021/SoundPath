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
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_music_id = ? and action = ?",current_user.id, user_id, id, 'favorite'])
    #いいねされていない場合に通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_music_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      #自分の投稿に対するいいねの場合は通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      if notification.valid?
        notification.save
        puts "Notification has been created." 
      else
        puts "Notification is invalid. Error messages: #{notification.errors.full_messages.join(', ')}" 
      end
    else
      puts "Notification already exists." 
    end
  end
  
  #コメントの通知 
  def create_notification_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_music_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, poast_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_music_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
  
end















