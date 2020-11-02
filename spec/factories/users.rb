FactoryBot.define do
  factory :user, class: User do
    name { 'Example User' }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    factory :other_user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end
  end



end
