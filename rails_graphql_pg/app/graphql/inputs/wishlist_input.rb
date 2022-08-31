module Inputs
  class WishlistInput < Types::BaseInputObject
    description "Attributes for Wishlist input"

    argument :id, ID, required: false, description: "Wishlist's ID"
    argument :publicity_level, Types::WishlistPublicityLevel,
             description: "Publicity level, example: Public", required: false
    argument :status, Types::WishlistStatus,
             description: "Status of the Wishlist, example: Pending", required: false
    argument :title, String, required: true, description: "Wishlist's title"
  end
end
