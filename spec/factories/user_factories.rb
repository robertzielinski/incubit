FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@gmail.com" }
    sequence(:username) { |n| "username#{n}" }
    password { 'test1234@' }
  end
end
