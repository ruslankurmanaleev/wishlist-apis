class Queries::User::GetMe < Queries::BaseQuery
  description "Get information about your account"

  type Types::UserPublicType, null: false

  def resolve
    fetch_current_user
  end

  private

  def fetch_current_user
    User.find_by(id: context[:current_user])
  end
end
