require "rails_helper"

RSpec.describe Wishlist, type: :model do
  let(:statuses) { { pending: 0, completed: 1, archived: 2 } }

  describe "validations" do
    it { is_expected.to(belong_to(:user)) }

    it { is_expected.to(validate_presence_of(:title)) }
  end
end
