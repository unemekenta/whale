module Api
  module V1
    class InformationContentsController < ApplicationController

      include ApiResponse
      include FormatData
      def index
        session_options_skip
        information = InformationContent.where("start_at <= ? AND end_at >= ?", format_unixtime_to_datetime(params[:start_at]), format_unixtime_to_datetime(params[:end_at])).order(:updated_at)
        return_data('', information)
      end
    end
  end
end