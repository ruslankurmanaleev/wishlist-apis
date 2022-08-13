require "rails_helper"

RSpec.describe "Wishlist::Items", type: :request do
  let!(:user) { create(:user) }
  let!(:wishlist) { create(:wishlist, user: user) }
  let(:token) { jwt_and_refresh_token(user, "user").first }

  describe "GET /wishlists/:wishlist_id/items" do
    context "when user is authorized and wishlist exists" do
      let!(:item) { create(:item, user: user, wishlist: wishlist) }

      it "returns items for the wishlist" do
        get "/wishlists/#{wishlist.id}/items", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["items"]["data"].size).to eq 1
        expect(JSON.parse(response.body)["items"]["data"].first["attributes"]["title"]).to eq item.title
        expect(JSON.parse(response.body)["errors"]).to be_nil
      end
    end

    context "when user is authorized but wishlist doesn't exist" do
      it "returns error" do
        get "/wishlists/9999999/items", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["wishlist"]).to be_nil
        expect(JSON.parse(response.body)["messages"]).to eq "Items can't be found"
      end
    end
  end

  describe "/wishlists/:wishlist_id/items/:id" do
    context "when wishlist and item exists" do
      let!(:item) { create(:item, user: user, wishlist: wishlist) }

      it "returns an item" do
        get "/wishlists/#{wishlist.id}/items/#{item.id}", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["item"].size).to eq 1
        expect(JSON.parse(response.body)["item"]["data"]["attributes"]["title"]).to eq item.title
        expect(JSON.parse(response.body)["errors"]).to be_nil
      end
    end

    context "when item doesn't exist" do
      it "returns error" do
        delete "/wishlists/#{wishlist.id}/items/444", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["wishlist"]).to be_nil
        expect(JSON.parse(response.body)["messages"]).to eq "Item can't be found"
      end
    end
  end

  describe "POST /wishlists/:wishlist_id/items" do
    describe "when params are valid" do
      let(:item_params) { { title: "Some title" } }

      it "creates an item" do
        post "/wishlists/#{wishlist.id}/items",
             headers: { Authorization: "Bearer #{token}" }, params: { item: item_params }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["item"]).not_to be_nil
        expect(JSON.parse(response.body)["item"]["title"]).to eq item_params[:title]
        expect(JSON.parse(response.body)["errors"]).to be_nil
      end
    end

    describe "when params are invalid" do
      it "doesn't create an item" do
        post "/wishlists/#{wishlist.id}/items",
             headers: { Authorization: "Bearer #{token}" }, params: { item: { title: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["item"]).to be_nil
        expect(JSON.parse(response.body)["errors"]).to eq ["Title can't be blank"]
      end
    end
  end

  describe "PATCH /wishlists/:wishlist_id/items/:id" do
    let!(:item) { create(:item, user: user, wishlist: wishlist) }

    describe "when params are valid" do
      let(:new_title) { "New title" }

      it "updates an item" do
        patch "/wishlists/#{wishlist.id}/items/#{item.id}",
              headers: { Authorization: "Bearer #{token}" },
              params: { item: { title: new_title } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["item"]).not_to be_nil
        expect(JSON.parse(response.body)["item"]["title"]).to eq new_title
        expect(JSON.parse(response.body)["errors"]).to be_nil
      end
    end

    describe "when params are invalid" do
      let(:new_title) { nil }

      it "doesn't update an item" do
        patch "/wishlists/#{wishlist.id}/items/#{item.id}",
              headers: { Authorization: "Bearer #{token}" },
              params: { item: { title: new_title } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["item"]).to be_nil
        expect(JSON.parse(response.body)["errors"]).to eq ["Title can't be blank"]
      end
    end
  end

  describe "DELETE /wishlists/1" do
    context "when item exists" do
      let!(:item) { create(:item, user: user, wishlist: wishlist) }

      it "deletes an item" do
        delete "/wishlists/#{wishlist.id}/items/#{item.id}", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["item"]).not_to be_nil
        expect(Item.where(id: item.id)).to be_empty
      end
    end

    context "when item doesn't exist" do
      it "returns error" do
        delete "/wishlists/#{wishlist.id}/items/9999999", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["item"]).to be_nil
        expect(JSON.parse(response.body)["messages"]).to eq "Item can't be found"
      end
    end
  end
end
