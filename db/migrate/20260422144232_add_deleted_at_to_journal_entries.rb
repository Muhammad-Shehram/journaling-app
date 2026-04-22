class AddDeletedAtToJournalEntries < ActiveRecord::Migration[7.2]
  def change
    add_column :journal_entries, :deleted_at, :datetime
    add_index :journal_entries, :deleted_at
  end
end
