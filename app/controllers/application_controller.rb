class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :load_sidebar_data, if: :user_signed_in?

  private

  def load_sidebar_data
    @sidebar_journals = current_user.journals.order(:name)
    @sidebar_new_entry_journal = current_user.journals.find_by(is_default: true) ||
                                  current_user.journals.order(updated_at: :desc).first
    @deleted_count = current_user.journal_entries.recently_deleted.count
  end
end
