# frozen_string_literal: true

module API
  module V1
    module Users
      class Base < ::API::V1::Base
        resource :users do
          mount Create
        end
      end
    end
  end
end