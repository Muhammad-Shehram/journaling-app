class Journal < ApplicationRecord
  belongs_to :user
  has_many :journal_entries, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: { scope: :user_id, message: "already exists in your collection" },
                   length: { minimum: 3, maximum: 20 }
  validates :color, format: { with: /\A#[0-9A-Fa-f]{6}\z/, message: "must be a valid hex color (e.g. #3ABF6A)" },
                    allow_blank: true
end
