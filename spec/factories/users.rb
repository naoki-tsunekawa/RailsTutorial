FactoryBot.define do
  factory :user, class: User do
    name { 'Example User' }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    # アカウントの有効化を行う
    activated { true }
    activated_at { Time.zone.now }

    factory :other_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end
  end
end
