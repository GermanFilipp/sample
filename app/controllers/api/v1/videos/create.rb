# frozen_string_literal: true

module API
  module V1
    module Videos
      class Create < Base
        params do
          requires :start_time, type: Integer, values: ->(v) { v >= 0 }
          requires :end_time, type: Integer, values: ->(v) { v >= 0 }, greater_than: :start_time
          requires :video, type: File, content_type: %w(video/mp4 video/avi), min_duration_length: :end_time
        end

        post do
          ::Video.create(
            user_id: current_user.id,
            start_time: params[:start_time],
            end_time: params[:end_time]
          ).tap do |video|
            ::Attachment.create(
              video: video,
              file: params[:video]
            )
  
            video.process!
          end

          status :ok
        end
      end
    end
  end
end