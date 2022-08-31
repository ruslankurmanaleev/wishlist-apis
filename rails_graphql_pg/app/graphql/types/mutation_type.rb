module Types
  class MutationType < Types::BaseObject
    # Auth
    field :sign_in, mutation: Mutations::Auth::SignIn, description: "Authenticate"
    field :sign_up, mutation: Mutations::Auth::SignUp, description: "Register new account"

    # Wishlists
    field :create_wishlist, mutation: Mutations::Wishlists::CreateWishlist, description: "Create new Wishlist"
    field :delete_wishlist, mutation: Mutations::Wishlists::DeleteWishlist, description: "Delete existing Wishlist"
    field :update_wishlist, mutation: Mutations::Wishlists::UpdateWishlist, description: "Update existing Wishlist"

    # Items
    field :create_item, mutation: Mutations::Items::CreateItem, description: "Create new Item"
    field :delete_item, mutation: Mutations::Items::DeleteItem, description: "Delete existing Item"
    field :update_item, mutation: Mutations::Items::UpdateItem, description: "Update existing Item"
  end
end
