class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user_found = User.find(params[:id])
    @post_musics= @user_found.post_musics
    @favorites = @user_found.favorites
  end
  
  def edit
    is_matching_login_user
    @user_found = User.find(params[:id])
  end
  
  def update
    is_matching_login_user
    @user_found = User.find(params[:id])
    if @user_found.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user_found)
    else
      render :edit
    end
  end
  
  def check
    
  end
  
  # 退会機能
  def withdrawal
    @user = current_user
    # is_activeカラムをfalseに変更し退会できるようにする
    @user.update(is_active: false)
    # ログアウトさせる
    reset_session
    flash[:notice] = "Withdrawal has been completed."
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path
    end
  end
  
end
















