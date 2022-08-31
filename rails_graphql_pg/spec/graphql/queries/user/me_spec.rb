require "rails_helper"

RSpec.describe Queries::User::GetMe, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let(:query) do
      <<~GQL
        query {
          getMe {
            id
            email
          }
        }
      GQL
    end

    it "returns information about self" do
      post "/graphql", params: { query: query }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["getMe"]["id"]).to eq user.id
      expect(json["data"]["getMe"]["email"]).to eq user.email
    end
  end
end
