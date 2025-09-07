# spec/factories/model_options.rb
FactoryBot.define do
  factory :model_option do
    association :smartphone_model
    association :body_color
    association :memory
  end
end