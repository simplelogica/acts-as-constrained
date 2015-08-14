# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :offer do
    name { Faker::Lorem.sentence }

    trait :with_single_date_constraint do
      single_date_constraint_starts_at { (7+rand*10).to_i.days.ago }
      single_date_constraint_ends_at { (7+rand*10).to_i.days.from_now }
    end
  end
end
