class SendReminderEmailJob < ApplicationJob
  queue_as :default

  DAYS = %w[Sun Mon Tue Wed Thu Fri Sat].freeze

  def perform
    User.where(reminders_enabled: true).find_each do |user|
      user_now = Time.current.in_time_zone(user.timezone.presence || "London")
      today    = DAYS[user_now.wday]

      days = user.reminder_days.to_s.split(",").map(&:strip)
      next unless days.include?(today)

      now_minutes  = user_now.hour * 60 + user_now.min
      window_start = (now_minutes / 5) * 5

      h, m = user.reminder_time.to_s.strip.split(":").map(&:to_i)
      reminder_minutes = h * 60 + m
      next unless reminder_minutes >= window_start && reminder_minutes < window_start + 5

      ReminderMailer.daily_reminder(user).deliver_later
    rescue => e
      Rails.logger.error "SendReminderEmailJob failed for user #{user.id}: #{e.message}"
    end
  end
end
