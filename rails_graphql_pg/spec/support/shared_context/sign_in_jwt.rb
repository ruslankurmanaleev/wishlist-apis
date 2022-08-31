RSpec.shared_context "with user jwt token" do
  let!(:user) { create(:user) }
  let(:headers) do
    {
      ACCEPT: "application/json",
      Authorization: "Bearer #{JsonWebToken.encode({ user_id: user.id })}"
    }
  end
end
