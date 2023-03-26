module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!
      include ReturnData

      def index
        session_options_skip
        comments = Comment.where(task_id: params[:task_id]).limit(INDEX_LIMIT).offset(params[:offset])
        return_data(STATUS_SUCCESS, '', comments)
      end

      def show
        session_options_skip
        return_data(STATUS_SUCCESS, '', @comment)
      end

      def create
        session_options_skip
        user = User.find_by(email: params[:uid])
        comment = Comment.new(content: params[:content], task_id: params[:task_id], user_id: user.id)
        comment.save
        return_data(STATUS_SUCCESS, '', comment)
      end

      def update
        session_options_skip
        if @comment.update(comment_params)
          return_data(STATUS_SUCCESS, 'Updated the comment', @comment)
        else
          return_data(STATUS_SUCCESS, 'Not updated', @comment.errors)
        end
      end

      def destroy
        session_options_skip
        @comment.destroy
        return_data(STATUS_SUCCESS, 'Deleted the comment', @comment)
      end

      private
      def set_comment
        session_options_skip
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.permit(:content)
      end
    end
  end
end
