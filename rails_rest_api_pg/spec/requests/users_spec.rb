require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "Authentication (api_guard)" do
    describe "POST /users/sign_up" do
      let(:body_json) do
        {
          email: "user@example.com",
          password: "api_password",
          password_confirmation: "api_password"
        }
      end

      it "successfully signs up" do
        post("/users/sign_up", params: body_json)

        expect(response).to have_http_status(:ok)
        expect(response.header["Access-Token"]).not_to be_nil
        expect(response.message).to eq "OK"
      end
    end

    describe "POST /users/sign_in" do
      let(:user) { create(:user) }
      let(:body_json) { { email: user.email, password: "password" } }

      it "successfully signs up" do
        post("/users/sign_in", params: body_json)

        expect(response).to have_http_status(:ok)
        expect(response.header["Access-Token"]).not_to be_nil
        expect(response.message).to eq "OK"
      end
    end
  end
end
