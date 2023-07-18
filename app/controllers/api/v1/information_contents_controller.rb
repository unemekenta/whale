module Api
  module V1
    class InformationContentsController < ApplicationController

      include ReturnData
      def index
        session_options_skip
        information = InformationContent.where("start_at >= ? AND end_at <= ?", params[:start_at], params[:end_at]).order(:updated_at)
        return_data(STATUS_SUCCESS, '', information)
      end
    end
  end
end