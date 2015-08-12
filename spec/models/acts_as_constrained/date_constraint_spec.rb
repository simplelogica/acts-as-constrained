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

end
