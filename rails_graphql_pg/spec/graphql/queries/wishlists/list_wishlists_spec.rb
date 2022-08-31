require "rails_helper"

RSpec.describe Queries::Wishlists::ListWishlists, type: :request do
  context "when Wishlist attributes requested" do
    describe ".resolve" do
      include_context "with user jwt token"

      let!(:wishlists) { create_pair(:wishlist, user: user) }

      let(:query) do
        <<~GQL
          query {
            listWishlists {
              id
            }
          }
        GQL
      end

      it "returns information about self" do
        post "/graphql", params: { query: query }, headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["data"]["listWishlists"].size).to eq wishlists.size
      end
    end
  end

  context "when Wishlist with Items are requested" do
    describe ".resolve" do
      include_context "with user jwt token"

      let!(:wishlist) { create(:wishlist, user: user) }
      let!(:items) { create_pair(:item, wishlist: wishlist, user: user) }

      let(:query) do
        <<~GQL
          query {
            listWishlists {
              id
              items {
                id
              }
            }
          }
        GQL
      end

      it "returns information about self" do
        post "/graphql", params: { query: query }, headers: headers

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["data"]["listWishlists"][0]["id"]).to eq wishlist.id
        expect(json["data"]["listWishlists"][0]["items"].size).to eq items.size
      end
    end
  end
end
