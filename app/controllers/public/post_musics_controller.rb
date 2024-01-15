class Public::PostMusicsController < ApplicationController
  
  def new
    @post_music = PostMusic.new
  end
  
  def create
    @post_music = PostMusic.new(post_music_params)
    @post_music.user_id = current_user.id
    @post_music.save
    redirect_to post_musics_path
  end
  
  def index
    @post_musics = PostMusic.all
  end
  
  private

def post_music_params
  params.require(:post_music).permit(:body, :file, :title) 
end
  
end


