class PostMusic < ApplicationRecord
  belongs_to :user
  has_one_attached :audio
  mount_uploader :file, AudiofileUploader
  
  def self.search(keyword)
    if keyword.present?
      PostMusic.where(['title LIKE(?) OR body Like(?)', "%#{keyword}%", "%#{keyword}%"])
    else
      @post_musics = PostMusic.all
    end
  end
  
end




