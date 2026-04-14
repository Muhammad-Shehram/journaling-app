class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # ASSOCIATION: A user can have many entries
  has_many :journal_entries, through: :journals
  has_many :journals, dependent: :destroy
end
