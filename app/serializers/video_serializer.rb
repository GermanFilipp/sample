class VideoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :start_time, :end_time, :status

  attribute :original_file_url do |object|
    object.original_attachment.file.url
  end

  attribute :cropped_file_url do |object|
    object.cropped_attachment.file.url if object.cropped_attachment
  end
end
