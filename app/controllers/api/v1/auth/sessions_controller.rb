module Api
  module V1
    class Auth::SessionsController < ApplicationController
      before_action :authenticate_api_v1_user!
      include ApiResponse

      def index
        session_options_skip
        @user = current_api_v1_user
        render 'index', status: :ok
      end
    end
  end
end
