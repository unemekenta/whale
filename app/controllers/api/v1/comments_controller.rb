module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!
      include ApiResponse

      def index
        session_options_skip
        comments = Comment.where(task_id: params[:task_id]).limit(INDEX_LIMIT).offset(params[:offset])
        return_data('', comments)
      end

      def show
        session_options_skip
        return_data('', @comment)
      end

      def create
        session_options_skip
        user = User.find_by(email: params[:uid])
        comment = Comment.new(content: params[:content], task_id: params[:task_id], user_id: user.id)
        comment.save
        return_data('', comment)
      end

      def update
        session_options_skip
        if @comment.user_id == @current_api_v1_user.id
          if @comment.update(comment_params)
            return_data('Updated the comment', @comment)
          else
            return_data('Not updated', @comment.errors)
          end
        else
          return_error('You are not authorized to update this comment', '')
        end
      end

      def destroy
        session_options_skip
        if @comment.user_id == @current_api_v1_user.id
          @comment.destroy
          return_data('Deleted the comment', @comment)
        else
          return_error('You are not authorized to delete this comment', '')
        end
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
