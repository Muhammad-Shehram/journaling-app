class AddIsDefaultToJournals < ActiveRecord::Migration[7.2]
  def change
    add_column :journals, :is_default, :boolean, default: false, null: false
  end
end
