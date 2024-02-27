class Public::FavoritesController < ApplicationController
  
  def create
    post_music = PostMusic.find(params[:post_music_id])
    favorite = current_user.favorites.new(post_music_id: post_music.id)
    if favorite.save
      post_music.create_notification_favorite!(current_user)
      redirect_to post_music_path(post_music)  
    end
  end
  
  def destroy
    post_music = PostMusic.find(params[:post_music_id])
    favorite = current_user.favorites.find_by(post_music_id: post_music.id)
    favorite.destroy
    redirect_to post_music_path(post_music)
  end
  
  def index
    @favorites = current_user.favorites
  end
  
end













