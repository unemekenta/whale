module Api
  module V1
    class InformationContentsController < ApplicationController
      before_action :set_page_params, only: [:index]

      PAGE_LIMIT = 20
      DEFAULT_PAGE = 1

      include FormatData
      include ApiResponse

      def index
        session_options_skip
        @information_contents = InformationContent.where("start_at <= ? AND end_at >= ?", format_unixtime_to_datetime(params[:start_at]), format_unixtime_to_datetime(params[:end_at]))
          .order(:updated_at)
          .page(@now_page).per(PAGE_LIMIT)

        render 'index', status: :ok
      end

      private

      def set_page_params
        @now_page = params[:page]? params[:page].to_i : DEFAULT_PAGE
      end
    end
  end
end