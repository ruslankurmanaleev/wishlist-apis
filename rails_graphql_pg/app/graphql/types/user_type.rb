module Types
  class UserType < Types::BaseObject
    description "User internal structure"

    field :id, Int, description: "User's ID"

    field :email, String, description: "User's email"
    field :password_digest, String, description: "Digest"
  end
end
