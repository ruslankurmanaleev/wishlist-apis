require "rails_helper"

RSpec.describe Queries::Wishlist::GetWishlist, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let(:wishlist) { create(:wishlist, user: user) }

    let(:query) do
      <<~GQL
        query {
          getWishlist(id: #{wishlist.id}) {
            id
          }
        }
      GQL
    end

    it "returns information about self" do
      post "/graphql", params: { query: query }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["getWishlist"]["id"]).to eq wishlist.id
    end
  end
end
