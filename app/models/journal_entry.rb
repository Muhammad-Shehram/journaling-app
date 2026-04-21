class JournalEntry < ApplicationRecord
  belongs_to :journal
  has_one :user, through: :journal
  has_rich_text :content
  has_one_attached :cover_photo
  has_many :entry_tags, dependent: :destroy
  has_many :tags, through: :entry_tags

  validates :title, presence: true
  validates :entry_date, presence: true
end
