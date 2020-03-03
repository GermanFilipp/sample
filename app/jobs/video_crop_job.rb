class VideoCropJob < ApplicationJob
  queue_as :default

  def perform(video_id)
    video = Video.find_by(id: video_id)
    if video
      cropped_video = VideoCropperService.new(
        attachment: video.original_attachment, 
        start_time: video.start_time, 
        end_time: video.end_time
      ).call

      if cropped_video.present? && cropped_video.valid?
        attachment = Attachment.find_or_initialize_by(
          video: video,
          attachment_type: Attachment.attachment_types[:cropped],
        )
        attachment.file = cropped_video
        if attachment.save
          video.done!
        else
          video.fail!
        end
      else
        video.fail!
      end
    end
  end
end
