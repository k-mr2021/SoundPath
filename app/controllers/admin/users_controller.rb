class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all
  end
  
  def show
    @user_found = User.find(params[:id])
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
    params.require(:user).permit(:name, :email, :is_active)
  end
end



