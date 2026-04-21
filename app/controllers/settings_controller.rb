class SettingsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update_profile
    if current_user.update_without_password(profile_params)
      redirect_to settings_path, notice: "Profile updated."
    else
      flash.now[:alert] = current_user.errors.full_messages.to_sentence
      render :show, status: :unprocessable_entity
    end
  end

  def update_password
    if current_user.update_with_password(password_params)
      bypass_sign_in(current_user)
      redirect_to settings_path, notice: "Password updated."
    else
      flash.now[:alert] = current_user.errors.full_messages.to_sentence
      render :show, status: :unprocessable_entity
    end
  end

  def destroy_account
    current_user.destroy
    sign_out current_user
    redirect_to root_path, notice: "Your account has been deleted."
  end

  private

  def profile_params
    params.require(:user).permit(:name, :email)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
