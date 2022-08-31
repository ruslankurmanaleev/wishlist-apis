module Types
  class UserPublicType < Types::BaseObject
    description "User public structure"

    field :email, String, description: "User's email"
    field :id, Int, description: "User's ID"
  end
end
