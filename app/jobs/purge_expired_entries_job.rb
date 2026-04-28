class PurgeExpiredEntriesJob < ApplicationJob
  queue_as :default

  def perform
    # destroy_all (not delete_all) to trigger dependent: :destroy on entry_tags
    count = JournalEntry
              .where.not(deleted_at: nil)
              .where("deleted_at <= ?", 30.days.ago)
              .destroy_all
              .length
    Rails.logger.info "PurgeExpiredEntriesJob: destroyed #{count} expired entries"
  rescue => e
    Rails.logger.error "PurgeExpiredEntriesJob failed: #{e.message}"
    raise
  end
end
