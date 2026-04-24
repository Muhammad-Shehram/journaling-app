class Tag < ApplicationRecord
  belongs_to :user
  has_many :entry_tags, dependent: :destroy
  has_many :journal_entries, through: :entry_tags

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }

  before_save { self.name = name.strip.downcase }
end
