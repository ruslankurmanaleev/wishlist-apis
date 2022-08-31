module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # User
    field :get_me, resolver: Queries::User::GetMe, description: "Get information your account"

    # Items
    field :get_item, resolver: Queries::Items::GetItem, description: "Get Item by ID"
    field :list_items, resolver: Queries::Items::ListItems, description: "List all User's Items"

    # Wishlists
    field :get_wishlist, resolver: Queries::Wishlists::GetWishlist, description: "Get Wishlist by ID"
    field :list_wishlists, resolver: Queries::Wishlists::ListWishlists, description: "List all User's Wishlists"
  end
end
