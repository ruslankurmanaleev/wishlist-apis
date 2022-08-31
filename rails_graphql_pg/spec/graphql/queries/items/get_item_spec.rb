require "rails_helper"

RSpec.describe Queries::Items::GetItem, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let!(:wishlist) { create(:wishlist, user: user) }
    let!(:item) { create(:item, wishlist: wishlist, user: user) }

    let(:query) do
      <<~GQL
        query {
          getItem(id: #{item.id}) {
            id
          }
        }
      GQL
    end

    it "returns information about self" do
      post "/graphql", params: { query: query }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["getItem"]["id"]).to eq item.id
    end
  end
end
