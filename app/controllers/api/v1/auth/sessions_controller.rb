module Api
  module V1
    class Auth::SessionsController < ApplicationController
      before_action :authenticate_api_v1_user!
      include ApiResponse

      def index
        session_options_skip
        return_data('', current_api_v1_user)
      end
    end
  end
end
