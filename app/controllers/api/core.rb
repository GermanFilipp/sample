# frozen_string_literal: true

module API
  class Core < Grape::API
    prefix :api
    helpers AuthHelper
    helpers JsonHelper

    mount API::V1::Base
  end
end