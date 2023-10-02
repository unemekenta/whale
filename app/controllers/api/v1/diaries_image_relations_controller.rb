module Api
  module V1
    class DiariesImageRelationsController < ApplicationController
      before_action :set_diaries_image_relation, only: [:destroy]
      before_action :authenticate_api_v1_user!

      include ApiResponse

      def create
        ActiveRecord::Base.transaction do
          session_options_skip
          params[:diaries_image_relation].each do |t|
            diaries_image_relation = DiariesImageRelation.new(diary_id: params[:diary_id], image_id: t[:image_id])
            diaries_image_relation.save!
          end
          head :ok
        end
      end

      def destroy
        session_options_skip
        if @diaries_image_relation.destroy
          render 'destroy', status: :ok
        else
          render 'destroy', status: :internal_server_error
        end
      end

      private
      def set_diaries_image_relation
        session_options_skip
        @diaries_image_relation = DiariesImageRelation.find(params[:diary_id])
      end
    end
  end
end
