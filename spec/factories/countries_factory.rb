# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :country do
    name { Faker::Lorem.sentence }
  end
end
