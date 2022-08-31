require "rails_helper"

RSpec.describe Mutations::Items::CreateItem, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let!(:wishlist) { create(:wishlist, user: user) }
    let(:query) do
      <<~GQL
        mutation {
          createItem(input: { wishlistId: #{wishlist.id}, title: "New title", status: PENDING }) {
            success
            errors
            item {
              id
            }
          }
        }
      GQL
    end

    it "creates an item" do
      post "/graphql", params: { query: query }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["createItem"]["success"]).to be_truthy
      expect(json["data"]["createItem"]["errors"]).to be_empty
      expect(json["data"]["createItem"]["item"]["id"]).not_to be_nil
    end
  end
end
