require 'rails_helper'

describe ActsAsConstrained::DateConstraint do

  let(:offer) { create :offer }

  context "when asigning date constraints" do

    before do
      offer.date_constraints << create(:date_constraint)
      offer.date_constraints << create(:date_constraint)
    end

    subject { offer }

    it "should have the constraints" do
      expect(subject.date_constraints).not_to be_blank
    end

  end

  context "when filtering by constraints" do

    before do
      offer.date_constraints << create(:date_constraint, starts_at: Date.yesterday, ends_at: Date.tomorrow)
    end

    subject { offer }

    it "should find the offer when filtered by the right date" do
      expect(Offer.constrained_by_date).not_to be_blank
    end

  end

end
