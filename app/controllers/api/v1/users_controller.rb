module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_user, only: [:show, :edit, :update, :destroy]
      include ApiResponse

      def show
        session_options_skip
        @user = current_api_v1_user
        render 'show', status: :ok
      end
    end

    def update
      session_options_skip
      if user_params[:image].present?
        # 画像を更新する場合
        @user.image = user_params[:image]
        if @user.save
          render 'update', status: :ok
        else
          render 'update', status: :internal_server_error
        end
      else
        # 画像を更新しない場合
        if @user.update(user_params.except(:image))
          render 'update', status: :ok
        else
          render 'update', status: :internal_server_error
        end
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
  end
end
