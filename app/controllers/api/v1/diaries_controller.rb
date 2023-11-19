module Api
  module V1
    class DiariesController < ApplicationController
      before_action :authenticate_api_v1_user!, except: [:timeline, :show]
      before_action :set_diary, only: [:update, :destroy]
      before_action :set_page_params, only: [:index, :timeline]

      include ApiResponse

      PAGE_LIMIT = 20
      DEFAULT_PAGE = 1

      def index
        session_options_skip
        @diaries = Diary.where(user_id: @current_api_v1_user.id)
          .includes(diary_comments: :user, diaries_image_relations: :image)
          .order(date: :desc)
          .page(@now_page).per(PAGE_LIMIT)

        render 'index', status: :ok
      end

      def show
        session_options_skip
        @diary = Diary.includes(diary_comments: :user, diaries_image_relations: :image)
          .where("(id = ? AND user_id = ?) OR (id = ? AND is_public = ?)",
            params[:id], @current_api_v1_user&.id,
            params[:id], true)
          .first
        render 'show', status: :ok
      end

      def create
        ActiveRecord::Base.transaction do
          session_options_skip
          user = User.find_by(email: params[:uid])
          @diary = Diary.new(title: params[:title], content: params[:content], is_public: params[:is_public], date: params[:date], user_id: user.id)
          @diary.save!

          if params[:diaries_image_relations].present?
            diaries_image_relation_params = JSON.parse(params[:diaries_image_relations])
            diaries_image_relation_params.each do |dir_id|
              diaries_image_relation = DiariesImageRelation.new(diary_id: @diary.id, image_id: dir_id)
              diaries_image_relation.save!
            end
          end
          render 'create', status: :ok
        end
      end

      def update
        # TODO: transactionの整合性確認
        ActiveRecord::Base.transaction do
          session_options_skip
          if params[:diaries_image_relations].present?
            diaries_image_relation_params = JSON.parse(params[:diaries_image_relations])
            existing_diaries_image_relation = @diary.diaries_image_relations.pluck(:image_id)

            # 削除するレコードを検出して削除する
            # TODO: destroy_allは例外を投げないので、削除できなかった場合は例外を投げる]
            @diary.diaries_image_relations.where(image_id: existing_diaries_image_relation - diaries_image_relation_params).destroy_all

            diaries_image_relation_params.each do |dir_id|
              next if existing_diaries_image_relation.include?(dir_id)
              diaries_image_relation = DiariesImageRelation.new(diary_id: @diary.id, image_id: dir_id)
              diaries_image_relation.save!
            end
          end
          if @diary.user_id == @current_api_v1_user.id
            @diary.update!(diary_params)
          else
            render 'update', status: :unauthorized
          end
        end
      end

      def destroy
        if @diary.user_id == @current_api_v1_user.id
          @diary.destroy
          render 'destroy', status: :ok
        else
          render 'destroy', status: :unauthorized
        end
      end

      def timeline
        session_options_skip
        @diaries = Diary.
          includes(diary_comments: :user, diaries_image_relations: :image).
          joins(:user).
          where(is_public: true).
          order(date: :desc).
          page(@now_page).per(PAGE_LIMIT)

        render 'timeline', status: :ok
      end

      private
      def set_diary
        session_options_skip
        @diary = Diary.includes(diaries_image_relations: :image).find(params[:id])
      end

      def set_page_params
        @now_page = params[:page]? params[:page].to_i : DEFAULT_PAGE
      end

      def diary_params
        params.permit(:title, :content, :is_public, :date)
      end
    end
  end
end
