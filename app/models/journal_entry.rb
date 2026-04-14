class JournalEntry < ApplicationRecord
  # ASSOCIATION: Each entry must belong to a journal
  belongs_to :journal
  has_one :user, through: :journal

  # VALIDATIONS: Rules for saving data
  validates :title, presence: true   # James cannot leave the title blank
  validates :content, presence: true # James must write something in the body
  validates :entry_date, presence: true    # Every entry needs a date for the timeline
end
