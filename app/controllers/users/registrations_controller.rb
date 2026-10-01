class Users::RegistrationsController < Devise::RegistrationsController
  # --- Reflekto pause (Oct 2026): sign-ups temporarily disabled ---
  # Delete this line to re-enable new account creation.
  before_action :block_new_registrations, only: [:new, :create]

  protected

  def after_inactive_sign_up_path_for(resource)
    users_check_inbox_path
  end

  private

  def block_new_registrations
    redirect_to new_user_session_path, alert: "New sign-ups are paused right now. Check back soon."
  end
end
