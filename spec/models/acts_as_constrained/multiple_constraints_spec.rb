require 'rails_helper'

describe ActsAsConstrained do


  context "when filtering by multiple constraints" do

    let!(:good_date_good_market_offer) do
      create :offer,
        model_constraints: [create(:model_constraint, constraining: market)],
        date_constraints: [create(:date_constraint,
          starts_at: 7.days.ago,
          ends_at: 7.days.from_now
        )]
    end

    let!(:good_date_bad_market_offer) do
      create :offer,
        model_constraints: [create(:model_constraint, constraining: create(:market))],
        date_constraints: [create(:date_constraint,
          starts_at: 7.days.ago,
          ends_at: 7.days.from_now
        )]
    end

    let!(:bad_date_good_market_offer) do
      create :offer,
        model_constraints: [create(:model_constraint, constraining: market)],
        date_constraints: [create(:date_constraint,
          starts_at: 7.days.from_now,
          ends_at: 17.days.from_now
        )]
    end

    let!(:bad_date_bad_market_offer) do
      create :offer,
        model_constraints: [create(:model_constraint, constraining: create(:market))],
        date_constraints: [create(:date_constraint,
          starts_at: 7.days.from_now,
          ends_at: 17.days.from_now
        )]
    end

    let(:market) { create :market }

    let!(:offers_with_good_market) { [good_date_good_market_offer, bad_date_good_market_offer] }
    let!(:offers_with_good_date) { [good_date_good_market_offer, good_date_bad_market_offer] }

    before do
      create :offer
      create :offer
    end

    subject { offer }

    it "should find the offer when filtered by the right date" do
      expect(Offer.constrained_by_market(market)).to match_array offers_with_good_market
      expect(Offer.constrained_by_date(Time.now)).to match_array offers_with_good_date
      expect(Offer.constrained_by_date(Time.now).constrained_by_market(market)).to match_array [good_date_good_market_offer]
    end

  end

end
