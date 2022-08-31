require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to(have_many(:wishlists).dependent(:destroy)) }
    # it { is_expected.to(validate_presence_of(:email)) }
    # it { is_expected.to(validate_presence_of(:password_digest)) }
  end
end
