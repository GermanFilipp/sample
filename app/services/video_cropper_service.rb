class VideoCropperService
  def initialize(attachment:, start_time:, end_time:)
    @attachment = attachment  
    @start_time = start_time
    @end_time   = end_time
  end

  def call    
    process
  end

  private
  attr_reader :attachment, :start_time, :end_time

  BASE_OPTIONS = {
    video_codec: 'copy'.freeze,
    audio_codec: 'copy'.freeze
  }.freeze

  def process
    begin
      ::FFMPEG::Movie.new(attachment.file.path)
        .transcode(output, options)
    rescue ::FFMPEG::Error
      return
    end
  end

  def options
    BASE_OPTIONS.merge(
        custom: %W[-ss #{seconds_to_str(start_time)} -to #{seconds_to_str(end_time)}]
    )
  end

  def seconds_to_str(time)
    Time.at(time).utc.strftime("%H:%M:%S")
  end

  def output
    Rails.root.join("tmp", "cropped_#{File.basename(attachment.file.path)}").to_s
  end
end