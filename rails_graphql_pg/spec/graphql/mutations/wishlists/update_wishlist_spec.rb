require "rails_helper"

RSpec.describe Mutations::Wishlists::UpdateWishlist, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let(:wishlist) { create(:wishlist, user: user) }
    let(:new_title) { "New Title" }
    let(:query) do
      <<~GQL
        mutation {
          updateWishlist(input: { id: "#{wishlist.id}", title: "#{new_title}" }) {
            success
            errors
            wishlist {
              title
            }
          }
        }
      GQL
    end

    it "updates the wishlist" do
      post "/graphql", params: { query: query }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["updateWishlist"]["success"]).to be_truthy
      expect(json["data"]["updateWishlist"]["errors"]).to be_empty
      expect(json["data"]["updateWishlist"]["wishlist"]["title"]).to eq new_title
    end
  end
end
