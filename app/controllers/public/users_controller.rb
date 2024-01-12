class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(current_user.id)
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
    flash[:notice] = "退会が完了しました。"
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :introduction)
  end
  
end


