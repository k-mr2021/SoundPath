class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_musics, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  has_one_attached :profile_image

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest.user@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'Guest'
    end
  end

  # 画像設定
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # 一意性を持たせ、かつ2～20文字の範囲で設定
  validates :name, uniqueness: true, length: { in: 2..20 }

  # 最大50文字までに設定
  validates :introduction, length: { maximum: 50 }

  # userをフォロー
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  # userのフォロー解除
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  # フォローしているかどうか判定
  def following?(user)
    followings.include?(user)
  end

  # 検索機能
  def self.search(keyword)
    if keyword.present?
      User.where('name LIKE ?', "#{keyword}%")
    else
      @users = User.all
    end
  end

  #フォロー通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
















