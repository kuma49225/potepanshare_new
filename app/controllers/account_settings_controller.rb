class AccountSettingsController < ApplicationController
  before_action :authenticate_user!

  def show_account
    @user = current_user
  end

  def edit_account
    @user = current_user
  end

  def update_account
    @user = current_user
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to show_account_settings_path, notice: 'アカウント情報を更新しました。'
    else
      render :edit_account
    end
  end

  def show_profile
    @user = current_user
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(profile_params)
      redirect_to show_profile_account_settings_path, notice: 'プロフィールを更新しました。'
    else
      render :edit_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end

  def profile_params
    params.require(:user).permit(:name, :profile_image, :bio)
  end
end
