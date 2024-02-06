# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # ログイン前に実行
  before_action :user_state, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  # ゲストログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(current_user), notice: 'ゲストユーザーとしてログインしました。'
  end
  
  # 退会機能
  private
  # アクティブであるか判断
  def user_state
    # [処理1] 入力されたemailからアカウントを1件取得
    user = User.find_by(email: params[:user][:email])
    # [処理2] アカウントを取得できなかった場合、このメソッドを終了
    return if user.nil?
    # [処理3] 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了
    return unless user.valid_password?(params[:user][:password])
    # 【処理4】 アクティブでない会員に対する処理
    if user
      if user.valid_password?(params[:user][:password]) && (user.is_active == true)
        
      else
        flash[:alert] = "このアカウントは退会済みです。"
        redirect_to new_user_registration_path
      end
    end
  end
end



