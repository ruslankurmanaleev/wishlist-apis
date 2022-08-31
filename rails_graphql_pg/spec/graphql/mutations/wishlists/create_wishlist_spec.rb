require "rails_helper"

RSpec.describe Mutations::Wishlists::CreateWishlist, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let(:query) do
      <<~GQL
        mutation {
          createWishlist(input: { title: "Test Wishlist", publicityLevel: PUBLIC, status: PENDING }) {
            errors
            success
            wishlist {
              id
            }
          }
        }
      GQL
    end

    it "creates a wishlistt" do
      post "/graphql", params: { query: query }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["createWishlist"]["success"]).to be_truthy
      expect(json["data"]["createWishlist"]["errors"]).to be_empty
      expect(json["data"]["createWishlist"]["wishlist"]["id"]).not_to be_nil
    end
  end
end
