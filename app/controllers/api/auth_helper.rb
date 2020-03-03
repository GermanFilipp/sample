# frozen_string_literal: true

module API
  module AuthHelper
    extend ::Grape::API::Helpers

    def authenticate_user!
      unauthorized_error unless authenticated?
    end

    def authenticated?
      bearer_token.present? && current_user.present?
    end

    def unauthorized_error
      error!(api_error("401 Unauthorized", 404), 401)
    end

    def current_user
      @user ||= user
    end

    private

    def user
      begin
        User.find_by!(digest: digest)
      rescue ActiveRecord::RecordNotFound
        unauthorized_error
      end
    end

    def digest
      begin
        JsonWebToken.decode(bearer_token).dig(:digest)
      rescue JWT::VerificationError, JWT::DecodeError
        unauthorized_error
      end
    end

    def bearer_token
      @bearer_token ||= begin
        pattern = /^Bearer /
        header  = request.headers['Authorization']
        header.gsub(pattern, '') if header && header.match(pattern)
      end
    end
  end
end
