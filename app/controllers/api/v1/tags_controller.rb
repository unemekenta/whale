module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!
      before_action :set_page_params, only: [:index]

      include ApiResponse

      PAGE_LIMIT = 20
      DEFAULT_PAGE = 1

      def index
        session_options_skip
        @tags = Tag.all
          .page(@now_page).per(PAGE_LIMIT)
        render 'index', status: :ok
      end

      def create
        session_options_skip
        @tag = Tag.new(name: params[:name])
        if @tag.save
          render 'create', status: :ok
        else
          render 'create', status: :internal_server_error
        end
      end

      def show
        session_options_skip
        render 'create', status: :ok
      end

      def update
        session_options_skip
        if @tag.update(tag_params)
          render 'update', status: :ok
        else
          render 'update', status: :internal_server_error
        end
      end

      def destroy
        session_options_skip
        if @tag.destroy
          render 'destroy', status: :ok
        else
          render 'destroy', status: :internal_server_error
        end
      end

      def search
        session_options_skip
        @tags = Tag.search(params[:keyword])
          .page(@now_page).per(PAGE_LIMIT)

        render 'index', status: :ok
      end

      private
      def set_tag
        session_options_skip
        @tag = Tag.find(params[:id])
      end

      def tag_params
        params.permit(:name)
      end

      def set_page_params
        @now_page = params[:page]? params[:page].to_i : DEFAULT_PAGE
      end
    end
  end
end
