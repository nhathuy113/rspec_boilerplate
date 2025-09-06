# spec/factories/smartphones.rb

FactoryBot.define do
  factory :smartphone do
    imei { Faker::Base.numerify('#' * 15) }  # Generates exactly 15 digits

    trait :with_body_color do
      body_color
    end

    trait :with_memory do
      memory
    end

    after(:build) do |smartphone|
      # You can add any post-build logic here
    end

    after(:create) do |smartphone|
      # You can add any post-create logic here
    end
  end
end
