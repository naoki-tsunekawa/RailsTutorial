FactoryBot.define do
  factory :user do
    name { 'Example User' }
    sequence(:email) { |n| "user_#{n}@example.com" }
  end
end
