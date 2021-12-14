# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :hotel do
    name { Faker::Lorem.sentence }
  end
end
