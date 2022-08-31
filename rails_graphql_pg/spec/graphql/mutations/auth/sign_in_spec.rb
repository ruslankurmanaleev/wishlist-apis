require "rails_helper"

module Mutations::Auth
  RSpec.describe SignIn, type: :request do
    describe ".resolve" do
      let!(:user) { create(:user) }
      let(:query) do
        <<~GQL
          mutation {
            signIn(input: { email: "#{user.email}", password: "#{user.password}" }) {
              token
              user {
                id
                email
              }
            }
          }
        GQL
      end

      it "creates a user session" do
        post "/graphql", params: { query: query }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json.dig("data", "signIn", "token")).not_to be_nil
        expect(json.dig("data", "signIn", "user", "email")).to eq user.email
      end
    end
  end
end
