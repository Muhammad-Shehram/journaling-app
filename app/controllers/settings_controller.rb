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

  def update_reminders
    attrs = reminders_params
    if params[:user][:reminder_days_list].present?
      attrs[:reminder_days] = Array(params[:user][:reminder_days_list]).join(",")
    end
    if current_user.update(attrs)
      redirect_to settings_path, notice: "Reminder preferences saved."
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update_appearance
    current_user.update!(dark_mode: params[:dark_mode] == "1")
    redirect_to settings_path
  end

  def export
    entries = current_user.journal_entries.active.includes(:journal, :tags).order(entry_date: :desc)
    content = render_to_string(template: "settings/export", formats: [:text], locals: { entries: entries }, layout: false)
    send_data content, filename: "reflekto_export_#{Date.today}.txt", type: "text/plain; charset=utf-8"
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

  def reminders_params
    params.require(:user).permit(:reminders_enabled, :reminder_time, :reminder_days, :reminder_email)
  end
end
