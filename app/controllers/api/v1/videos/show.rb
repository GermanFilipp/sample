# frozen_string_literal: true

module API
  module V1
    module Videos
      class Show < Base
        params do
          requires :id, type: Integer
        end

        route_param :id do
          get do
            video = Video.find_by!(id: params[:id], user_id: current_user.id)
            ::VideoSerializer.new(video).serializable_hash
          end
        end
      end
    end
  end
end