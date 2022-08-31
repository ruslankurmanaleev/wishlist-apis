class Mutations::Wishlists::UpdateWishlist < Mutations::BaseMutation
  description "Updates Wishlist for the user"

  argument :input, Inputs::WishlistInput, required: true, description: "Provide attributes of Wishlist"

  field :errors, [String], null: false, description: "Indicates Errors"
  field :success, Boolean, null: false, description: "Indicates Success"
  field :wishlist, Types::WishlistType, null: false, description: "Returns Wishlist"

  def authorized?(**_inputs)
    context[:current_user].present?
  end

  def resolve(input: nil)
    wishlist = fetch_wishlist(input.id)

    return { success: false, wishlist: nil, errors: [not_found_error_message] } unless wishlist

    if wishlist.update(input.to_h.except(:id))
      { success: true, wishlist: wishlist, errors: [] }
    else
      { success: false, wishlist: wishlist, errors: [wishlist.errors.full_messages] }
    end
  end

  private

  def fetch_wishlist(id)
    Wishlist.find_by(id: id, user_id: context[:current_user])
  end

  def not_found_error_message
    "Wishlist couldn't be found"
  end
end
