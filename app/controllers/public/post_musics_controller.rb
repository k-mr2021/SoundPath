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
    @user_found = User.find(current_user.id)
  end
  
  def edit
    @post_music = PostMusic.find(params[:id])
  end
  
  def update
    @post_music = PostMusic.find(params[:id])
    if @post_music.update(post_music_params)
      redirect_to post_musics_path(@post_music.id)
    else
      render :edit
    end
  end
  
  def destroy
    post_music = PostMusic.find(params[:id])
    post_music.destroy
    redirect_to post_musics_path
  end
  
  private

def post_music_params
  params.require(:post_music).permit(:body, :file, :title) 
end
  
end





