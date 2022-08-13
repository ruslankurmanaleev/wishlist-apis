class WishlistSerializer < BaseSerializer
  include JSONAPI::Serializer

  attributes :user_id, :title, :publicity_level, :status
end
