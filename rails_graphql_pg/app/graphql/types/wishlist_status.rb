class Types::WishlistStatus < Types::BaseEnum
  description "Statuses of Wishlist"

  value "PENDING", "Pending"
  value "COMPLETED", "Completed"
  value "ARCHIVED", "Archived"
end
