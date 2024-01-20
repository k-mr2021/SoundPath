class Public::PostCommentsController < ApplicationController

  def create
    post_music = PostMusic.find(params[:post_music_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.post_music_id = post_music.id
    comment.save
    redirect_to post_music_path(post_music)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_music_path(params[:post_music_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end





