require "rails_helper"

RSpec.describe Item, type: :model do
  let(:statuses) { { pending: 0, not_gifted: 1, gifted: 2 } }

  describe "validations" do
    it { is_expected.to(belong_to(:user)) }
    it { is_expected.to(belong_to(:wishlist)) }

    it { is_expected.to(validate_presence_of(:title)) }
    it { is_expected.to(define_enum_for(:status).with_values(statuses).with_prefix(:status)) }
  end
end
