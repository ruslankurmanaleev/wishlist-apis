class ItemSerializer < BaseSerializer
  include JSONAPI::Serializer

  attributes :user_id, :wishlist_id, :title, :link, :description, :status, :reserved_by,
             :gifted_by, :reserved_on, :gifted_on
end
