class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest.admin@example.com') do |admin|
      admin.password = SecureRandom.urlsafe_base64
    end
  end
  
end


