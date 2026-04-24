class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_sidebar_data, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def load_sidebar_data
    @sidebar_journals = current_user.journals.order(:name)
    @sidebar_new_entry_journal = current_user.journals.find_by(is_default: true) ||
                                  current_user.journals.order(updated_at: :desc).first
    @deleted_count = current_user.journal_entries.recently_deleted.count
  end
end
