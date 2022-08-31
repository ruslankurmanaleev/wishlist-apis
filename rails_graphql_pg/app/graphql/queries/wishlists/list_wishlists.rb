class Queries::Wishlists::ListWishlists < Queries::BaseQuery
  description "List all User's Wishlist"

  type [Types::WishlistType], null: true

  def resolve
    fetch_wishlists
  end

  private

  def fetch_wishlists
    context[:current_user].wishlists
  end
end
