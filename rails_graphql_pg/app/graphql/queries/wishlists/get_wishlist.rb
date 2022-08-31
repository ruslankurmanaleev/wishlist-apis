class Queries::Wishlists::GetWishlist < Queries::BaseQuery
  description "Get Wishlist"

  argument :id, ID, required: true, description: "Provide ID of Wishlist"

  type Types::WishlistType, null: true

  def resolve(input)
    fetch_wishlist(input[:id])
  end

  private

  def fetch_wishlist(id)
    Wishlist.find_by(id: id, user_id: context[:current_user])
  end
end
