class SendReminderEmailJob < ApplicationJob
  queue_as :default

  DAYS = %w[Sun Mon Tue Wed Thu Fri Sat].freeze

  def perform
    Rails.logger.info "[SendReminderEmailJob] Running at #{Time.current.utc}"

    User.where(reminders_enabled: true).find_each do |user|
      user_now = Time.current.in_time_zone(user.timezone.presence || "London")
      today    = DAYS[user_now.wday]

      days = user.reminder_days.to_s.split(",").map(&:strip)

      Rails.logger.info "[SendReminderEmailJob] user=#{user.id} local_time=#{user_now.strftime('%H:%M')} today=#{today} days=#{days.inspect} reminder_time=#{user.reminder_time}"

      unless days.include?(today)
        Rails.logger.info "[SendReminderEmailJob] user=#{user.id} skipped — #{today} not in reminder days"
        next
      end

      now_minutes      = user_now.hour * 60 + user_now.min
      window_start     = (now_minutes / 5) * 5
      reminder_h, reminder_m = user.reminder_time.to_s.split(":").map(&:to_i)
      reminder_minutes = reminder_h * 60 + reminder_m

      Rails.logger.info "[SendReminderEmailJob] user=#{user.id} window=#{window_start}-#{window_start + 5} reminder=#{reminder_minutes}"

      unless reminder_minutes >= window_start && reminder_minutes < window_start + 5
        Rails.logger.info "[SendReminderEmailJob] user=#{user.id} skipped — outside window"
        next
      end

      Rails.logger.info "[SendReminderEmailJob] user=#{user.id} SENDING reminder email"
      ReminderMailer.daily_reminder(user).deliver_now
      Rails.logger.info "[SendReminderEmailJob] user=#{user.id} email sent"
    rescue => e
      Rails.logger.error "[SendReminderEmailJob] FAILED for user #{user.id}: #{e.message}\n#{e.backtrace.first(3).join("\n")}"
    end
  end
end
