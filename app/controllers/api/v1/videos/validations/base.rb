module API
  module V1
    module Videos
      module Validations
        class Base < Grape::Validations::Base
          TIME_FORMAT = "%H:%M:%S".freeze

          def uploaded_file(file)
            begin 
              ActionDispatch::Http::UploadedFile.new(file)
            rescue TypeError
              nil
            end
          end
        end
      end
    end
  end
end