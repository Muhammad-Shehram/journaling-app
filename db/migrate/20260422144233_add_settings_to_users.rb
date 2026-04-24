class AddSettingsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :reminders_enabled, :boolean, default: false, null: false
    add_column :users, :reminder_time,     :string,  default: "09:00"
    add_column :users, :reminder_days,     :string,  default: "Mon,Tue,Wed,Thu,Fri"
    add_column :users, :reminder_email,    :boolean, default: true, null: false
    add_column :users, :dark_mode,         :boolean, default: false, null: false
  end
end
