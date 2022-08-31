require "json_web_token"

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    private

    def token_not_created_message
      "Server was unable to created token. Please try again later."
    end

    def unauthenticated_error_message
      "You must be logged in to perform this action"
    end
  end
end
