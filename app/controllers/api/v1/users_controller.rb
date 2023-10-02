module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!
      include ApiResponse

      def show
        session_options_skip
        @user = current_api_v1_user
        render 'user', status: :ok
      end
    end
  end
end
