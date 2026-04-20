class AddColorToJournals < ActiveRecord::Migration[7.2]
  def change
    add_column :journals, :color, :string, default: '#7C6FF7'
  end
end
