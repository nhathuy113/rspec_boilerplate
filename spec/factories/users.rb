FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:name) { |n| "User #{n}" }
    provider { 'google_oauth2' }
    sequence(:uid) { |n| "uid_#{n}" }

    trait :with_google_oauth do
      provider { 'google_oauth2' }
    end

    trait :with_github_oauth do
      provider { 'github' }
    end
  end
end
