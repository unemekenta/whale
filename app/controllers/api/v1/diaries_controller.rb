module Api
  module V1
    class DiariesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_diary, only: [:update, :destroy]
      include ReturnData

      def index
        session_options_skip
        diaries = Diary.where(user_id: @current_api_v1_user.id)
          .limit(INDEX_LIMIT)
          .offset(params[:offset])
          .order(date: :desc)
        return_data(STATUS_SUCCESS, '', diaries)
      end

      def show
        session_options_skip
        diary = Diary.includes(diaries_image_relations: :image)
          .where("(id = ? AND user_id = ?) OR (id = ? AND public = ?)",
            params[:id], @current_api_v1_user.id,
            params[:id], true)
          .first
          .as_json(include: [:diaries_image_relations, :images])
        return_data(STATUS_SUCCESS, '', diary)
      end

      def create
        ActiveRecord::Base.transaction do
          session_options_skip
          user = User.find_by(email: params[:uid])
          diary = Diary.new(title: params[:title], content: params[:content], public: params[:public], date: params[:date], user_id: user.id)
          diary.save

          if params[:diaries_image_relations].present?
            diaries_image_relation_params = JSON.parse(params[:diaries_image_relation])
            diaries_image_relation_params.each do |dir_id|
              diaries_image_relation = DiariesImageRelation.new(diary_id: diary.id, image_id: dir_id)
              diaries_image_relation.save
            end
          end
          return_data(STATUS_SUCCESS, '', diary)
        end
      end

      def update
        ActiveRecord::Base.transaction do
          if params[:diaries_image_relations].present?
            diaries_image_relation_params = JSON.parse(params[:diaries_image_relations])
            existing_diaries_image_relation = @diary.diaries_image_relations.pluck(:image_id)

            # 削除するレコードを検出して削除する
            @diary.diaries_image_relations.where(image_id: existing_diaries_image_relation - diaries_image_relation_params).destroy_all

            diaries_image_relation_params.each do |dir_id|
              next if existing_diaries_image_relation.include?(dir_id)
              diaries_image_relation = DiariesImageRelation.new(diary_id: @diary.id, image_id: dir_id)
              diaries_image_relation.save
            end
          end
          if @diary.user_id == @current_api_v1_user.id
            if @diary.update(diary_params)
              return_data(STATUS_SUCCESS, 'Updated the diary', @diary)
            else
              return_data(STATUS_SUCCESS, 'Not updated', @diary.errors)
            end
          else
            return_data(STATUS_FAILURE, 'You are not authorized to update this diary', '')
          end
        end
      end

      def destroy
        if @diary.user_id == @current_api_v1_user.id
          @diary.destroy
          return_data(STATUS_SUCCESS, 'Deleted the diary', @diary)
        else
          return_data(STATUS_FAILURE, 'You are not authorized to delete this diary', '')
        end
      end

      def timeline
        session_options_skip
        diaries = Diary.where(public: true).limit(INDEX_LIMIT).offset(params[:offset]).order(date: :desc)
        return_data(STATUS_SUCCESS, '', diaries)
      end

      private
      def set_diary
        session_options_skip
        @diary = Diary.includes(diaries_image_relations: :image).find(params[:id])
      end

      def diary_params
        params.permit(:title, :content, :public, :date)
      end

    end
  end
end
