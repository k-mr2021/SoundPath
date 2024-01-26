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
  
  has_many :notifications, as: :subject, dependent: :destroy
  
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
  
end









