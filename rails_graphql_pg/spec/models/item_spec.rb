require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    it { is_expected.to(belong_to(:user)) }
    it { is_expected.to(belong_to(:wishlist)) }

    it { is_expected.to(validate_presence_of(:title)) }
  end
end
