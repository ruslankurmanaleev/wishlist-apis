require "rails_helper"

RSpec.describe Mutations::Items::UpdateItem, type: :request do
  describe ".resolve" do
    include_context "with user jwt token"

    let!(:wishlist) { create(:wishlist, user: user) }
    let!(:item) { create(:item, wishlist: wishlist, user: user) }
    let(:new_title) { "Absolutely new title" }
    let(:query) do
      <<~GQL
        mutation {
          updateItem(input: { id: #{item.id}, wishlistId: #{wishlist.id}, title: "#{new_title}" }) {
            success
            errors
            item {
              title
            }
          }
        }
      GQL
    end

    it "creates an item" do
      post "/graphql", params: { query: query }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["data"]["updateItem"]["success"]).to be_truthy
      expect(json["data"]["updateItem"]["errors"]).to be_empty
      expect(json["data"]["updateItem"]["item"]["title"]).to eq new_title
    end
  end
end
