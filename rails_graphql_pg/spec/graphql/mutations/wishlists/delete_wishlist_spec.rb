require "rails_helper"

RSpec.describe Mutations::Wishlists::DeleteWishlist, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let(:wishlist) { create(:wishlist, user: user) }
    let(:query) do
      <<~GQL
        mutation {
          deleteWishlist(id: "#{wishlist.id}") {
            success
            errors
            wishlist {
              id
            }
          }
        }
      GQL
    end

    it "updates the wishlist" do
      post "/graphql", params: { query: query }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["deleteWishlist"]["success"]).to be_truthy
      expect(json["data"]["deleteWishlist"]["errors"]).to be_empty
      expect(json["data"]["deleteWishlist"]["wishlist"]["id"]).to eq wishlist.id
      expect(Wishlist.find_by(id: wishlist.id)).to be_nil
    end
  end
end
