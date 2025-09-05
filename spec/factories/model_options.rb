# spec/factories/model_options.rb
FactoryBot.define do
  factory :model_option do
    association :smartphone_model
    # Add other attributes as needed, like:
    # color { "Black" }
    # storage { "128GB" }
  end
end
