require 'rails_helper'

describe ActsAsConstrained::ModelConstraint do

  let(:offer) { create :offer }

  context "when asigning date constraints" do

    before do
      offer.model_constraints << create(:model_constraint)
      offer.model_constraints << create(:model_constraint)
    end

    subject { offer }

    it "should have the constraints" do
      expect(subject.model_constraints).not_to be_blank
    end

  end

  context "when filtering by constraints" do

    let(:market) { create :market }

    before do
      offer.model_constraints << create(:model_constraint, constraining: market)
      create :offer
      create :offer
    end

    subject { offer }

    it "should find the offer when filtered by the right date" do
      expect(Offer.constrained_by_market(market)).to eq [offer]
    end

  end

end
