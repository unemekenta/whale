module Api
  module V1
    class DiaryCommentsController < ApplicationController
      before_action :set_comment, only: [:show, :edit, :update, :destroy]
      before_action :authenticate_api_v1_user!
      before_action :set_page_params, only: [:index]

      include ApiResponse

      PAGE_LIMIT = 20
      DEFAULT_PAGE = 1

      def index
        session_options_skip
        @diary_comments = DiaryComment
          .where(user_id: current_api_v1_user.id)
          .includes(:diary)
          .page(@now_page).per(PAGE_LIMIT)

        render 'index', status: :ok
      end

      def show
        session_options_skip
        render 'show', status: :ok
      end

      def create
        session_options_skip
        @diary_comment = DiaryComment.new(content: params[:content], diary_id: params[:diary_id], user_id: current_api_v1_user.id)
        if @diary_comment.save
          render 'create', status: :ok
        else
          render 'create', status: :internal_server_error
        end
      end

      def edit
        session_options_skip
        render 'edit', status: :ok
      end

      def update
        session_options_skip
        if @diary_comment.user_id == current_api_v1_user.id
          if @diary_comment.update(comment_params)
            render 'update', status: :ok
          else
            render 'update', status: :internal_server_error
          end
        else
          render 'update', status: :unauthorized
        end
      end

      def destroy
        session_options_skip
        if @diary_comment.user_id == current_api_v1_user.id
          if @diary_comment.destroy
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
        @diary_comment = DiaryComment.find_by(id: params[:id], user_id: current_api_v1_user.id)
      end

      def comment_params
        params.permit(:content)
      end

      def set_page_params
        @now_page = params[:page]? params[:page].to_i : DEFAULT_PAGE
      end
    end
  end
end
