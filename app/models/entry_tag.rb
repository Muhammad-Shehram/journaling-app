class EntryTag < ApplicationRecord
  belongs_to :journal_entry
  belongs_to :tag

  validates :journal_entry_id, uniqueness: { scope: :tag_id }
end
