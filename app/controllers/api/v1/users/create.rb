# frozen_string_literal: true

module API
  module V1
    module Users
      class Create < Base

        post do
          user = User.new { |u| u.create_digest }
          user.save
          
          header "Authorization", "Bearer #{::JsonWebToken.encode({ digest: user.digest })}"

          status :created
        end
      end
    end
  end
end