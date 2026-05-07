class ChangeReminderDaysDefault < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :reminder_days, from: "Mon,Tue,Wed,Thu,Fri", to: ""
  end
end
