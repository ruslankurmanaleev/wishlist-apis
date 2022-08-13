require "rails_helper"

RSpec.describe "Wishlists", type: :request do
  let!(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, "user").first }

  describe "GET /wishlists" do
    context "when user is authorized and has wishlist" do
      let!(:wishlist) { create(:wishlist, user_id: user.id) }

      it "returns a wishlist" do
        get "/wishlists", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["wishlists"]["data"].size).to eq 1
        expect(JSON.parse(response.body)["wishlists"]["data"].first["attributes"]["title"]).to eq wishlist.title
        expect(JSON.parse(response.body)["errors"]).to be_nil
      end
    end

    context "when user is authorized and has no wishlists" do
      it "returns collection of wishlists" do
        get "/wishlists", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["wishlists"]["data"].size).to eq 0
        expect(JSON.parse(response.body)["errors"]).to be_nil
      end
    end
  end

  describe "GET /wishlists/1" do
    context "when wishlist exists" do
      let!(:wishlist) { create(:wishlist, user_id: user.id) }

      it "returns a wishlist" do
        get "/wishlists/#{wishlist.id}", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["wishlist"]).not_to be_nil
        expect(JSON.parse(response.body)["errors"]).to be_nil
      end
    end

    context "when wishlist doesn't exist" do
      it "returns error" do
        get "/wishlists/9999999", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["wishlist"]).to be_nil
        expect(JSON.parse(response.body)["messages"]).to eq "Wishlist can't be found"
      end
    end
  end

  describe "POST /wishlists" do
    describe "when params are valid" do
      let(:wishlist_params) { { title: "Some title" } }

      it "creates a wishlist" do
        post "/wishlists", headers: { Authorization: "Bearer #{token}" }, params: { wishlist: wishlist_params }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["wishlist"]).not_to be_nil
        expect(JSON.parse(response.body)["errors"]).to be_nil
      end
    end

    describe "when params are invalid" do
      it "doesn't create a wishlist" do
        post "/wishlists", headers: { Authorization: "Bearer #{token}" }, params: { wishlist: { title: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["wishlist"]).to be_nil
        expect(JSON.parse(response.body)["errors"]).to eq ["Title can't be blank"]
      end
    end
  end

  describe "PATCH /wishlists/1" do
    let!(:wishlist) { create(:wishlist, user_id: user.id) }
    let(:wishlist_params) { { title: new_title } }

    describe "when params are valid" do
      let(:new_title) { "New title" }

      it "updates a wishlist" do
        patch "/wishlists/#{wishlist.id}",
              headers: { Authorization: "Bearer #{token}" },
              params: { wishlist: wishlist_params }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["wishlist"]).not_to be_nil
        expect(JSON.parse(response.body)["wishlist"]["title"]).to eq new_title
        expect(JSON.parse(response.body)["errors"]).to be_nil
      end
    end

    describe "when params are invalid" do
      let(:new_title) { nil }

      it "updates a wishlist" do
        patch "/wishlists/#{wishlist.id}",
              headers: { Authorization: "Bearer #{token}" },
              params: { wishlist: wishlist_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["wishlist"]).to be_nil
        expect(JSON.parse(response.body)["errors"]).to eq ["Title can't be blank"]
      end
    end
  end

  describe "DELETE /wishlists/1" do
    context "when wishlist exists" do
      let!(:wishlist) { create(:wishlist, user_id: user.id) }

      it "deletes a wishlist" do
        delete "/wishlists/#{wishlist.id}", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["wishlist"]).not_to be_nil
        expect(Wishlist.where(id: wishlist.id)).to be_empty
      end
    end

    context "when wishlist doesn't exist" do
      it "returns error" do
        delete "/wishlists/9999999", headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["wishlist"]).to be_nil
        expect(JSON.parse(response.body)["messages"]).to eq "Wishlist can't be found"
      end
    end
  end
end
