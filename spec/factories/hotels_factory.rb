# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hotel do
    name { Faker::Lorem.sentence }
  end
end
