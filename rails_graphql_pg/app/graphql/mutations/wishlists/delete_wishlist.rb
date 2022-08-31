class Mutations::Wishlists::DeleteWishlist < Mutations::BaseMutation
  description "Removes Wishlist for the user"

  argument :id, ID, required: true, description: "Provide ID of Wishlist"

  field :errors, [String], null: false, description: "Indicates Errors"
  field :success, Boolean, null: false, description: "Indicates Success"
  field :wishlist, Types::WishlistType, null: false, description: "Returns Wishlist"

  def authorized?(**_inputs)
    context[:current_user].present?
  end

  def resolve(id: nil)
    wishlist = fetch_wishlist(id)

    if wishlist.destroy
      { success: true, wishlist: wishlist, errors: [] }
    else
      { success: false, wishlist: wishlist, errors: [removing_error_message] }
    end
  end

  private

  def fetch_wishlist(id)
    Wishlist.find_by(id: id, user_id: context[:current_user])
  end

  def removing_error_message
    "Can't remove the Wishlist"
  end
end
