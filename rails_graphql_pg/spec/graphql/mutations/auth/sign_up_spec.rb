require "rails_helper"

module Mutations::Auth
  RSpec.describe SignUp, type: :request do
    describe ".resolve" do
      let(:user) { build(:user) }
      let(:query) do
        <<~GQL
          mutation {
            signUp(input: {email: "#{user.email}", password: "#{user.password}"}) {
              token
              user {
                id
                email
              }
            }
          }
        GQL
      end

      it "create a user and signs in the user" do
        post "/graphql", params: { query: query }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json.dig("data", "signUp", "token")).not_to be_nil
        expect(json.dig("data", "signUp", "user", "email")).to eq user.email
      end
    end
  end
end
