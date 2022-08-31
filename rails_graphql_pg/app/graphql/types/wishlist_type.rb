# frozen_string_literal: true

module Types
  class WishlistType < Types::BaseObject
    description "Wishlist Schema"

    field :id, Integer, description: "ID of Wishlist"
    field :user_id, Integer, description: "User who created Wishlist"

    field :publicity_level, Types::WishlistPublicityLevel, description: "Publicity Level of Wishlist"
    field :status, Types::WishlistStatus, description: "Status of Wishlist"
    field :title, String, description: "Title of Wishlist"

    field :items, [Types::ItemType], description: "Linked Items"
  end
end
