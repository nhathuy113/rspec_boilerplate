# spec/factories/smartphone_models.rb
FactoryBot.define do
  factory :smartphone_model do
    name { "iPhone 13" }
    association :brand
    association :year
    association :os_version
  end
end