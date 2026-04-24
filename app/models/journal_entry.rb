class JournalEntry < ApplicationRecord
  belongs_to :journal
  has_one :user, through: :journal
  has_rich_text :content
  has_one_attached :cover_photo
  has_many :entry_tags, dependent: :destroy
  has_many :tags, through: :entry_tags

  validates :title, presence: true
  validates :entry_date, presence: true
  validate :cover_photo_is_image, if: -> { cover_photo.attached? }

  scope :active,           -> { where(deleted_at: nil) }
  scope :recently_deleted, -> { where.not(deleted_at: nil).where("deleted_at > ?", 30.days.ago) }

  def cover_photo_is_image
    unless cover_photo.content_type.start_with?("image/")
      errors.add(:cover_photo, "must be an image file (JPEG, PNG, GIF, WebP)")
      cover_photo.purge
    end
  end

  def soft_delete!
    update!(deleted_at: Time.current)
  end

  def recover!
    update!(deleted_at: nil)
  end

  def days_remaining
    return 0 if deleted_at.nil?
    [30 - ((Time.current - deleted_at) / 86400).floor, 0].max
  end
end
