class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable
  # ASSOCIATION: A user can have many entries
  has_many :journals, dependent: :destroy
  has_many :journal_entries, through: :journals
  has_many :tags, dependent: :destroy

  validate :password_complexity, if: :password_required?

  after_create  :create_default_journal
  after_create  :seed_starter_tags
  after_commit  :send_welcome_email, on: :create

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end

  def create_default_journal
    journals.create!(name: "Journal", color: "#50C878", is_default: true)
  end

  def seed_starter_tags
    %w[
      grateful anxious excited reflective peaceful inspired frustrated hopeful
      work health family relationships travel personal-growth creativity finances
      morning evening weekend milestone goal habit
    ].each { |name| tags.create!(name: name) }
  end

  def password_complexity
    return if password.blank?
    errors.add(:password, "must be at least 12 characters") if password.length < 12
    errors.add(:password, "must contain at least one uppercase letter") unless password.match?(/[A-Z]/)
    errors.add(:password, "must contain at least one number") unless password.match?(/[0-9]/)
    errors.add(:password, "must contain at least one special character (!@#$%^&*)") unless password.match?(/[!@#$%^&*]/)
  end
end
