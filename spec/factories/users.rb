FactoryBot.define do
  factory :user do
    username { "testuser" }
    password { "password123" }
    email { "testuser@example.com" }
  end
end
