# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :date_constraint, class: ActsAsConstrained::DateConstraint do
    starts_at { (7+rand*10).to_i.days.ago }
    ends_at { (7+rand*10).to_i.days.from_now }
  end
end
