class Journal < ApplicationRecord
  belongs_to :user
  has_many :journal_entries, dependent: :destroy

  # Prevents duplicate names across the entire app
  validates :name, presence: true,
                   uniqueness: { scope: :user_id, message: "already exists in your collection" },
                   length: { minimum: 3, maximum: 20 }
end
