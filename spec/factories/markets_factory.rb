# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :market do
    name { Faker::Lorem.sentence }
  end
end
