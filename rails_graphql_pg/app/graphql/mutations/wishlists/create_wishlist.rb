class Mutations::Wishlists::CreateWishlist < Mutations::BaseMutation
  description "Creates Wishlist for the user"

  argument :input, Inputs::WishlistInput, required: true, description: "Provide ID of Wishlist"

  field :errors, [String], null: false, description: "Indicates Errors"
  field :success, Boolean, null: false, description: "Indicates Success"
  field :wishlist, Types::WishlistType, null: false, description: "Returns Wishlist"

  def authorized?(**_inputs)
    context[:current_user].present?
  end

  def resolve(input: nil)
    wishlist = build_wishlist(input)

    if wishlist.save
      { success: true, wishlist: wishlist, errors: [] }
    else
      { success: true, wishlist: wishlist, errors: wishlist.errors.full_messages }
    end
  end

  private

  def build_wishlist(input)
    context[:current_user].wishlists.build(input.to_h)
  end
end
