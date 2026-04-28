class SendReminderEmailJob < ApplicationJob
  queue_as :default

  DAYS = %w[Sun Mon Tue Wed Thu Fri Sat].freeze

  def perform
    today        = DAYS[Time.current.wday]
    current_hhmm = Time.current.strftime("%H:%M")

    User.where(reminders_enabled: true, reminder_email: true).find_each do |user|
      days = user.reminder_days.to_s.split(",").map(&:strip)
      next unless days.include?(today)
      next unless user.reminder_time.to_s.strip == current_hhmm

      ReminderMailer.daily_reminder(user).deliver_later
    rescue => e
      Rails.logger.error "SendReminderEmailJob failed for user #{user.id}: #{e.message}"
    end
  end
end
