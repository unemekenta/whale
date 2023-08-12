module Api
  module V1
    class ImagesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_image, only: [:destroy]
      include ApiResponse

      def index
        session_options_skip
        images = Image.where(user_id: @current_api_v1_user.id).order("created_at DESC")
        return_data('', images)
      end

      def show
        session_options_skip
        image = Image.where(user_id: @current_api_v1_user.id).find_by(id: params[:id])
        return_data('', image)
      end

      def create
        session_options_skip
        user = User.find_by(email: params[:uid])
        image = Image.new(image: params[:image], image_content_type: params[:image_content_type], image_file_size: params[:image_file_size], image_type: params[:image_type], caption: params[:caption], user_id: user.id)
        if image.save
          return_data('', image)
        else
          return_error(image.errors.full_messages, '')
        end
      end

      def destroy
        if @image.user_id == @current_api_v1_user.id
          @image.destroy
          return_data('Deleted the image', @image)
        else
          return_error('You are not authorized to delete this image', '')
        end
      end

      private

      def set_image
        session_options_skip
        @image = Image.find(params[:id])
      end

      def post_params
        params.permit(:user_id, :image, :image_content_type, :image_file_size, :image_type, :caption)
      end
    end
  end
end
