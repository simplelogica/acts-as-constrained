require 'rails_helper'

describe ActsAsConstrained::DateConstraint do

  let!(:offer) { create :offer, :with_single_date_constraint }

  context "when filtering by constraints" do

    before do
      create :offer
      create :offer
    end

    subject { offer }

    it "should find the offer when filtered by the right date" do
      expect(Offer.constrained_by_single_date).not_to be_blank
    end

  end

end
