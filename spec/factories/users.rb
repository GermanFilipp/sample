FactoryBot.define do
  factory :user do
    digest { SecureRandom.hex }
  end
end