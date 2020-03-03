class Attachment < ApplicationRecord
    belongs_to :video

    enum attachment_types: {
      original: 0,
      cropped: 1,
    }

    mount_uploader :file, VideoUploader
end
