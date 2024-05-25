FactoryBot.define do
  factory :session do
    token { SecureRandom.hex }
    association :user
  end
end
