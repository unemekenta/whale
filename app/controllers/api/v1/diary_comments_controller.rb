module Api
  module V1
    class DiaryCommentsController < ApplicationController
      before_action :set_comment, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!

      include ReturnData
      def index
        session_options_skip
        comments = DiaryComment.where(diary_id: params[:diary_id]).limit(INDEX_LIMIT).offset(params[:offset])
        return_data(STATUS_SUCCESS, '', comments)
      end

      def show
        session_options_skip
        return_data(STATUS_SUCCESS, '', @diary_comment)
      end

      def create
        session_options_skip
        user = User.find_by(email: params[:uid])
        comment = DiaryComment.new(content: params[:content], diary_id: params[:diary_id], user_id: user.id)
        comment.save
        return_data(STATUS_SUCCESS, '', comment)
      end

      def update
        session_options_skip
        if @diary_comment.user_id == @current_api_v1_user.id
          if @diary_comment.update(comment_params)
            return_data(STATUS_SUCCESS, 'Updated the comment', @diary_comment)
          else
            return_data(STATUS_SUCCESS, 'Not updated', @diary_comment.errors)
          end
        else
          return_data(STATUS_FAILURE, 'You are not authorized to update this comment', '')
        end
      end

      def destroy
        session_options_skip
        Rails.logger.debug("ここ#{@diary_comment}")
        if @diary_comment.user_id == @current_api_v1_user.id
          @diary_comment.destroy
          return_data(STATUS_SUCCESS, 'Deleted the comment', @diary_comment)
        else
          return_data(STATUS_FAILURE, 'You are not authorized to delete this comment', '')
        end
      end

      private
      def set_comment
        session_options_skip
        @diary_comment = DiaryComment.find(params[:id])
      end

      def comment_params
        params.permit(:content)
      end
    end
  end
end
