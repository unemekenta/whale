module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show]
      include ApiResponse

      def show
        session_options_skip
        render 'show', status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

    end
  end
end
