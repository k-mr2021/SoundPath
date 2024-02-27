class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all.page(params[:page]).per(10)
  end
  
  def show
    @user_found = User.find(params[:id])
    @post_musics= @user_found.post_musics
  end
  
  def edit
    @user_found = User.find(params[:id])
  end
  
  def update
    @user_found =User.find(params[:id])
    @user_found.update(user_params)
    # user詳細へリダイレクト
    redirect_to admin_user_path(@user_found)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :product, :email, :is_active)
  end
end





