# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors, logger: (-> { Rails.logger }) do
  allow do
    origins "*"
    resource "/api/*", headers: :any, methods: %i[get post put patch delete options]
  end
end