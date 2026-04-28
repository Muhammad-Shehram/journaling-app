Rails.application.configure do
  config.good_job.execution_mode = :async
  config.good_job.max_threads    = 5
  config.good_job.poll_interval  = 30

  config.good_job.cron = {
    send_reminder_emails: {
      cron:        "*/5 * * * *",
      class:       "SendReminderEmailJob",
      description: "Send journal reminder emails to eligible users every 5 minutes"
    },
    purge_expired_entries: {
      cron:        "0 3 * * *",
      class:       "PurgeExpiredEntriesJob",
      description: "Destroy soft-deleted entries older than 30 days (runs daily at 03:00 UTC)"
    }
  }
end
