FactoryBot.define do
  factory :attachment do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "fixtures", "files", "sample_video.mp4")) }

    trait :original do
      attachment_type { 0 }
    end

    trait :cropped do
      attachment_type { 1 }
    end
  end
end