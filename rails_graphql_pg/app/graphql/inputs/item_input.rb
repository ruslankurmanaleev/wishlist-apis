module Inputs
  class ItemInput < Types::BaseInputObject
    description "Attributes for Item input"

    argument :id, Int, required: false, description: "ID of the Item"
    argument :wishlist_id, Int, description: "ID of the Wishlist"

    argument :description, String, required: false, description: "Description, example: I need it so bad!"
    argument :gifted_on, GraphQL::Types::ISO8601DateTime, required: false,
                                                          description: "DateTime when the Item was gifted"
    argument :link, String, required: false, description: "Link to Item, example: ozon.ru"
    argument :reserved_on, GraphQL::Types::ISO8601DateTime, required: false,
                                                            description: "DateTime when the Item was reserved"
    argument :status, Types::ItemStatus, required: false, description: "Status of the Item, example: Pending"
    argument :title, String, required: false, description: "Item's title"
  end
end
