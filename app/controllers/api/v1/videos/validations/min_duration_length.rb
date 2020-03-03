module API
  module V1
    module Videos
      module Validations
        class MinDurationLength < Base

          def validate_param!(attr_name, params)

            file = uploaded_file(params[attr_name])
            return unless file && file.path

            ffmpeg = FFMPEG::Movie.new(file.path)

            unless ffmpeg.valid? && params[@option] <= ffmpeg.duration
              fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "duration must be more than #{@option}"
            end
          end

        end
      end
    end
  end
end