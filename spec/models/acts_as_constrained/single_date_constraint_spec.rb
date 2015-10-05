require 'rails_helper'

describe ActsAsConstrained::DateConstraint do

  let!(:offer) { create :offer, :with_single_date_constraint }
  let!(:offer_without_starts_at) { create :offer, :with_single_date_constraint, single_date_constraint_starts_at: nil }
  let!(:offer_without_ends_at) { create :offer, :with_single_date_constraint, single_date_constraint_ends_at: nil }

  context "when filtering by constraints" do

    before do
      create :offer
      create :offer
    end

    subject { offer }

    it "should find the offer when filtered by the right date" do
      expect(Offer.constrained_by_single_date).to match_array [offer, offer_without_starts_at, offer_without_ends_at]
    end

  end

end
