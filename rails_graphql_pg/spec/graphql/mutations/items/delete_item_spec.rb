require "rails_helper"

RSpec.describe Mutations::Items::DeleteItem, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let!(:wishlist) { create(:wishlist, user: user) }
    let!(:item) { create(:item, wishlist: wishlist, user: user) }
    let(:query) do
      <<~GQL
        mutation {
          deleteItem(id: #{item.id}) {
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
      expect(json["data"]["deleteItem"]["success"]).to be_truthy
      expect(json["data"]["deleteItem"]["errors"]).to be_empty
      expect(json["data"]["deleteItem"]["item"]["id"]).not_to be_nil
    end
  end
end
