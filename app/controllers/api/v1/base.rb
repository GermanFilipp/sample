# frozen_string_literal: true

module API
  module V1
    class Base < Core
      version "v1", using: :path
      format :json
      content_type :json, "application/vnd.api+json"

      mount Videos::Base
      mount Users::Base
    end
  end
end