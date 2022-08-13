require "rails_helper"

RSpec.describe Wishlist, type: :model do
  let(:statuses) { { pending: 0, completed: 1, archived: 2 } }
  let(:publicity_levels) { { closed: 0, by_link: 1, opened: 2 } }

  describe "validations" do
    it { is_expected.to(belong_to(:user)) }

    it { is_expected.to(validate_presence_of(:title)) }
    it { is_expected.to(define_enum_for(:status).with_values(statuses).with_prefix(:status)) }
    it { is_expected.to(define_enum_for(:publicity_level).with_values(publicity_levels).with_prefix(:publicity_level)) }
  end
end
