# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    field :id, Integer, description: "Item's ID"
    field :user_id, Types::UserType, description: "Creator of Item"
    field :wishlist_id, Types::WishlistType, description: "ID of linked Wishlist"

    field :description, String, description: "Description of Item"
    field :link, String, description: "Link to Item on some web-shop"
    field :reserved, Boolean, description: "Reservation flag. Boolean"
    field :reserved_on, GraphQL::Types::ISO8601DateTime, description: "Date and Time of reservation"
    field :status, Types::ItemStatus, description: "Status of Item"
    field :title, String, description: "Title of Item"

    field :wishlist, Types::WishlistType, description: "Linked Wishlist"
  end
end
