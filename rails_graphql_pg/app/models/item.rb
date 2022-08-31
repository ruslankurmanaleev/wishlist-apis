class Item < ApplicationRecord
  belongs_to :user
  belongs_to :wishlist

  validates :title, presence: true
end
