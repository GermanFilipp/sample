require_relative 'boot'

# require 'rails/all'

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load
module VideoCropper
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.autoload_paths << Rails.root.join('app', 'services')
    config.middleware.use Rack::Attack
    config.api_only = true
    config.active_job.queue_adapter = :sidekiq
    config.generators do |g|
      g.test_framework :rspec
      g.factory_bot dir: 'spec/factories'
    end
  end
end
