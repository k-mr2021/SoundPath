class Public::SearchesController < ApplicationController
  
   
  def index
    @keyword = search_params[:keyword]
    @users = User.search(@keyword)
    @post_musics = PostMusic.search(@keyword)
  end
  
  private

def search_params
  params.permit(:keyword)
end
  
end

















