module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!
      before_action :set_page_params, only: [:index]

      include ApiResponse

      PAGE_LIMIT = 20
      DEFAULT_PAGE = 1

      def index
        session_options_skip
        @comments = Comment
          .where(task_id: params[:task_id])
          .page(@now_page).per(PAGE_LIMIT)
        render 'index', status: :ok
      end

      def show
        session_options_skip
        render 'show', status: :ok
      end

      def create
        session_options_skip
        @comment = Comment.new(content: params[:content], task_id: params[:task_id], user_id: current_api_v1_user.id)
        if @comment.save
          render 'create', status: :ok
        else
          render 'create', status: :internal_server_error
        end
      end

      def update
        session_options_skip
        if @comment.user_id == @current_api_v1_user.id
          if @comment.update(comment_params)
            render 'update', status: :ok
          else
            render 'update', status: :internal_server_error
          end
        else
          ender 'update', status: :unauthorized
        end
      end

      def destroy
        session_options_skip
        if @comment.user_id == @current_api_v1_user.id
          if @comment.destroy
            render 'destroy', status: :ok
          else
            render 'destroy', status: :internal_server_error
          end
        else
          render 'destroy', status: :unauthorized
        end
      end

      private
      def set_comment
        session_options_skip
        @comment = Comment.find(params[:id])
      end

      def set_page_params
        @now_page = params[:page]? params[:page].to_i : DEFAULT_PAGE
      end

      def comment_params
        params.permit(:content)
      end
    end
  end
end
