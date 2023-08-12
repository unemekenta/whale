module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!
      include ApiResponse

      def index
        session_options_skip
        tasks = Tag.all.limit(INDEX_LIMIT).offset(params[:offset])
        return_data('', tasks)
      end

      def create
        session_options_skip
        tag = Tag.new(name: params[:name])
        tag.save
        return_data('', tag)
      end

      def show
        session_options_skip
        return_data('', @tag)
      end

      def update
        session_options_skip
        if @tag.update(tag_params)
          return_data('Updated the tag', @tag)
        else
          return_data('Not updated', @tag.errors)
        end
      end

      def destroy
        session_options_skip
        @tag.destroy
        return_data('Deleted the tag', @tag)
      end

      def search
        session_options_skip
        @tags = Tag.search(params[:keyword])
        return_data('', @tags)
      end

      private
      def set_tag
        session_options_skip
        @tag = Tag.find(params[:id])
      end

      def tag_params
        params.permit(:name)
      end
    end
  end
end
