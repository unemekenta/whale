module Api
  module V1
    class TaggingsController < ApplicationController
      before_action :set_tagging, only: [:destroy]
      before_action :authenticate_api_v1_user!
      include ApiResponse

      def index
        session_options_skip
        @taggings = Tagging.where(task_id: params[:task_id]).limit(INDEX_LIMIT).offset(params[:offset])
        render 'index', status: :ok
      end

      def create
        ActiveRecord::Base.transaction do
          session_options_skip
          params[:tagging].each do |t|
            tagging = Tagging.new(task_id: params[:task_id], tag_id: t[:tag_id])
            tagging.save!
          end
          head :ok
        end
      end

      def destroy
        session_options_skip
        @tagging.destroy
        render 'destroy', status: :ok
      end

      private
      def set_tagging
        session_options_skip
        @tagging = Tagging.find(params[:id])
      end
    end
  end
end
