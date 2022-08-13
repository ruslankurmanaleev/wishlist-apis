class Item < ApplicationRecord
  belongs_to :user
  belongs_to :wishlist

  enum status: { pending: 0, not_gifted: 1, gifted: 2 }, _prefix: :status

  validates :title, presence: true
end
