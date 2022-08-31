require "json_web_token"

class Mutations::Auth::SignUp < Mutations::BaseMutation
  description "Sign Up the user into the system"

  argument :input, Inputs::SignInInput, required: true, description: "Provide Sign Up attributes"

  field :token, String, null: false,
                        description: "User's Authorizations Token to be used in Authenticated mutations and queries"
  field :user, Types::UserType, null: false, description: "User output"

  def authorized?(**_inputs)
    true
  end

  def resolve(input: nil)
    user = User.new(email: input.email, password: input.password)

    return_token_and_user!(user)
  end

  private

  def return_token_and_user!(user)
    raise GraphQL::ExecutionError, user.errors.full_messages.join(", ") unless user.save

    token = JsonWebToken.encode({ user_id: user.id })

    raise GraphQL::ExecutionError, token_not_created_message unless token

    { token: token, user: user }
  end
end
