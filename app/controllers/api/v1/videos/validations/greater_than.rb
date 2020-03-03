module API
  module V1
    module Videos
      module Validations
        class GreaterThan < Base

          def validate_param!(attr_name, params)
            return unless params[@option] && params[attr_name]

            unless params[@option] <= params[attr_name]
              fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "must be greater or equal than #{@option}"
            end
          end

        end
      end
    end
  end
end