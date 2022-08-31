require "rails_helper"

RSpec.describe Queries::Items::ListItems, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let!(:wishlist) { create(:wishlist, user: user) }
    let!(:items) { create_pair(:item, wishlist: wishlist, user: user) }

    let(:query) do
      <<~GQL
        query {
          listItems {
            id
          }
        }
      GQL
    end

    it "returns information about self" do
      post "/graphql", params: { query: query }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["listItems"].size).to eq items.size
    end
  end
end
