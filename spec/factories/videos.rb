FactoryBot.define do
  factory :video do
    start_time { "00:00:10" }
    end_time { "00:00:15" }
    user

    after(:create) do |video|
      create(:attachment, :original, video: video)
      create(:attachment, :cropped, video: video)
    end
  end
end