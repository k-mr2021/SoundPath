class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :post_musics, dependent: :destroy
  
  def self.search(keyword)
    if keyword.present?
      User.where('name LIKE ?', "#{keyword}%")
    else
      @users = User.all 
    end
  end
  
end







