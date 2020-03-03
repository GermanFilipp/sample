# frozen_string_literal: true
%w(greater_than content_type min_duration_length).each do |file|
  require_relative  "validations/#{file}"
end

module API
  module V1
    module Videos
      class Base < ::API::V1::Base
        resource :videos do
          before { authenticate_user! }

          rescue_from ActiveRecord::RecordNotFound do |e|
            error!(api_error(e.message, 404), 404)
          end

          rescue_from Grape::Exceptions::ValidationErrors do |e|
            error!(api_error(e.message, 400), 400)
          end

          mount Index
          mount Show
          mount Create
          mount Restart
          mount Delete
        end
      end
    end
  end
end