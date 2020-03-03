# frozen_string_literal: true

module API
  module V1
    module Videos
      class Index < Base
        params do
          optional :page, type: Integer, default: 1
          optional :per_page, type: Integer, default: 10
        end

        get do
          videos = Video.where(user_id: current_user).page(params[:page]).per(params[:per_page])

          ::VideoSerializer.new(videos, { meta: generate_pagination(videos) }).serializable_hash
        end
      end
    end
  end
end