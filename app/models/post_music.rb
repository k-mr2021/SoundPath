class PostMusic < ApplicationRecord
  
  has_one_attached :audio
  mount_uploader :file, AudiofileUploader
  
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  
  def self.search(keyword)
    if keyword.present?
      PostMusic.where(['title LIKE(?) OR body Like(?)', "%#{keyword}%", "%#{keyword}%"])
    else
      @post_musics = PostMusic.all
    end
  end
  
end




