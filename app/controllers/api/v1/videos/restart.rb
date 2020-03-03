# frozen_string_literal: true

module API
  module V1
    module Videos
      class Restart < Base
        params do
          requires :id, type: Integer
        end

        route_param :id do
          patch do
            video = Video.find_by!(id: params[:id], user_id: current_user.id)

            video.restart!

            status :ok
          end
        end
      end
    end
  end
end