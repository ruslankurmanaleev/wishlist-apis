require "json_web_token"

class Mutations::Auth::SignIn < Mutations::BaseMutation
  description "Sign In the user into the system"

  argument :input, Inputs::SignInInput, required: true, description: "Pass Sign In attributes"

  field :token, String, null: false,
                        description: "User's Authorizations Token to be used in Authenticated mutations and queries"
  field :user, Types::UserType, null: false, description: "User output"

  def authorized?(**_inputs)
    true
  end

  def resolve(input: nil)
    user = User.find_by(email: input&.email)

    # binding.irb
    raise GraphQL::ExecutionError, invalid_credentials_message unless user&.password.eql?(input&.password)

    authenticate!(user)
  end

  private

  def authenticate!(user)
    token = JsonWebToken.encode({ user_id: user.id })

    raise GraphQL::ExecutionError, token_not_created_message unless token

    { token: token, user: user }
  end

  def invalid_credentials_message
    "Invalid Credentials Provided."
  end
end
