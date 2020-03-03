class VideoUploader < CarrierWave::Uploader::Base
  VIDEO_WHITELIST = %w(mp4 avi)

  storage :file 

  def extension_white_list
    VIDEO_WHITELIST
  end

  def store_dir
    dir = Rails.env.test? ? 'test_uploads' : 'uploads'
    "#{dir}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
