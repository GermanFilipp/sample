module API
  module V1
    module Videos
      module Validations
        class ContentType < Base

          def validate_param!(attr_name, params)
            file = uploaded_file(params[attr_name])
            return unless file && file.path

            unless @option.include?(file.content_type)
              fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "must be type of #{@option}"
            end
          end

        end
      end
    end
  end
end