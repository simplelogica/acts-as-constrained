require 'rails_helper'

describe ActsAsConstrained do


  context "when filtering by multiple constraints" do

    let!(:good_date_good_market_offer) do
      create :offer,
        model_constraints: [
          create(:model_constraint, constraining: market),
        ],
        date_constraints: [create(:date_constraint,
          starts_at: 7.days.ago,
          ends_at: 7.days.from_now
        )]
    end

    let!(:good_date_good_market_offer_with_country) do
      create :offer,
        model_constraints: [
          create(:model_constraint, constraining: market),
          create(:model_constraint, constraining: country),
        ],
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
    let(:country) { create :country }

    let!(:offers_with_good_market) { [good_date_good_market_offer_with_country, good_date_good_market_offer, bad_date_good_market_offer] }
    let!(:offers_with_good_date) { [good_date_good_market_offer_with_country, good_date_good_market_offer, good_date_bad_market_offer] }
    let!(:offers_with_good_market_and_country) { [good_date_good_market_offer_with_country, good_date_good_market_offer] }

    before do
      create :offer
      create :offer
    end

    subject { offer }

    it "should find the offer when filtered by the right constraints" do
      expect(Offer.constrained_by(model: [market])).to match_array offers_with_good_market
      expect(Offer.constrained_by(date: Time.now)).to match_array offers_with_good_date
      expect(Offer.constrained_by(date: Time.now, model: [market])).to match_array offers_with_good_market_and_country
      expect(
        Offer.constrained_by(date: Time.now, model: [market, country])
      ).to match_array [good_date_good_market_offer_with_country]
    end
  end

  context "when filtering by optional constraints" do

    let!(:good_date_good_market_hotel) do
      create :hotel,
        model_constraints: [
          create(:model_constraint, constraining: market),
        ],
        date_constraints: [create(:date_constraint,
          starts_at: 7.days.ago,
          ends_at: 7.days.from_now
        )]
    end

    let!(:bad_date_good_market_hotel) do
      create :hotel,
        model_constraints: [create(:model_constraint, constraining: market)],
        date_constraints: [create(:date_constraint,
          starts_at: 7.days.from_now,
          ends_at: 17.days.from_now
        )]
    end

    let(:market) { create :market }

    before do
      create :hotel
      create :hotel
    end

    subject { hotel }

    it "should find the hotels when filtered by the optional constraints" do
      expect(Hotel.constrained_by(model: [market])).to match_array [good_date_good_market_hotel, bad_date_good_market_hotel]
      expect(Hotel.constrained_by(date: Time.now, model: [market])).to match_array [good_date_good_market_hotel]
      expect(Hotel.constrained_by(date: 15.days.from_now, model: [market])).to match_array [bad_date_good_market_hotel]
      expect(Hotel.constrained_by(date: 45.days.from_now, model: [market])).to match_array [good_date_good_market_hotel, bad_date_good_market_hotel]
    end
  end

end
