class RemoveUserIdFromJournalEntries < ActiveRecord::Migration[7.2]
  def change
    remove_reference :journal_entries, :user, null: false, foreign_key: true
  end
end
