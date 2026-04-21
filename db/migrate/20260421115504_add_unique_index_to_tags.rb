class AddUniqueIndexToTags < ActiveRecord::Migration[7.2]
  def change
    add_index :tags, [:name, :user_id], unique: true
    add_index :entry_tags, [:journal_entry_id, :tag_id], unique: true
  end
end
