class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # ASSOCIATION: A user can have many entries
  has_many :journal_entries, through: :journals
  has_many :journals, dependent: :destroy

  validate :password_complexity, if: :password_required?

  private

  def password_complexity
    return if password.blank?
    errors.add(:password, "must be at least 8 characters") if password.length < 8
    errors.add(:password, "must contain at least one uppercase letter") unless password.match?(/[A-Z]/)
    errors.add(:password, "must contain at least one number") unless password.match?(/[0-9]/)
    errors.add(:password, "must contain at least one special character (!@#$%^&*)") unless password.match?(/[!@#$%^&*]/)
  end
end
