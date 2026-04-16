class AddJournalToJournalEntries < ActiveRecord::Migration[7.2]
  def change
    add_reference :journal_entries, :journal, null: false, foreign_key: true
  end
end
