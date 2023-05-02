module Api
  module V1
    class DiariesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_diary, only: [:show, :update, :destroy]
      include ReturnData

      def index
        session_options_skip
        diaries = Diary.where(user_id: @current_api_v1_user.id).limit(INDEX_LIMIT).offset(params[:offset])
        return_data(STATUS_SUCCESS, '', diaries)
      end

      def show
        return_data(STATUS_SUCCESS, '', @diary)
      end

      def create
        session_options_skip
        user = User.find_by(email: params[:uid])
        diary = Diary.new(title: params[:title], content: params[:content], public: params[:public], user_id: user.id)
        diary.save
        return_data(STATUS_SUCCESS, '', diary)
      end

      def update
        session_options_skip
        if @diary.update(diary_params)
          return_data(STATUS_SUCCESS, 'Updated the diary', @diary)
        else
          return_data(STATUS_SUCCESS, 'Not updated', @diary.errors)
        end
      end

      def destroy
        @diary.destroy
        return_data(STATUS_SUCCESS, 'Deleted the diary', @diary)
      end

      private
      def set_diary
        session_options_skip
        @diary = Diary.find(params[:id])
      end

      def diary_params
        params.permit(:title, :content, :public)
      end

    end
  end
end
