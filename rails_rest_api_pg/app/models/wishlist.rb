class Wishlist < ApplicationRecord
  belongs_to :user

  has_many :items, dependent: :destroy

  validates :title, presence: true

  enum publicity_level: { closed: 0, by_link: 1, opened: 2 }, _prefix: :publicity_level
  enum status: { pending: 0, completed: 1, archived: 2 }, _prefix: :status
end
