class RecentlyDeletedController < ApplicationController
  before_action :authenticate_user!

  def index
    purge_expired!
    @deleted_entries = current_user.journal_entries
                                   .recently_deleted
                                   .includes(:journal)
                                   .order(deleted_at: :desc)
  end

  def recover
    entry = current_user.journal_entries.find(params[:id])
    entry.recover!
    redirect_to recently_deleted_index_path, notice: "Entry restored to #{entry.journal.name}."
  end

  def recover_all
    current_user.journal_entries.recently_deleted.update_all(deleted_at: nil)
    redirect_to recently_deleted_index_path, notice: "All entries restored."
  end

  def destroy
    entry = current_user.journal_entries.find(params[:id])
    entry.destroy
    redirect_to recently_deleted_index_path, notice: "Entry permanently deleted."
  end

  def purge_all
    current_user.journal_entries.recently_deleted.destroy_all
    redirect_to recently_deleted_index_path, notice: "All entries permanently deleted."
  end

  private

  def purge_expired!
    current_user.journal_entries
                .where.not(deleted_at: nil)
                .where("deleted_at <= ?", 30.days.ago)
                .destroy_all
  end
end
