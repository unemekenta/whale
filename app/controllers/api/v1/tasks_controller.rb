module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!
      before_action :set_page_params, only: [:index]

      include ApiResponse

      PAGE_LIMIT = 20
      DEFAULT_PAGE = 1

      def index
        session_options_skip
        @tasks = Task.where(user_id: @current_api_v1_user.id)
          .where(@status == 'all' ? nil : { status: Task.statuses[@status] })
          .where(@priority == 'all' ? nil : { priority: Task.priorities[@priority] })
          .order("#{@sort} #{@order}")
          .page(@now_page).per(PAGE_LIMIT)
        render 'index', status: :ok
      end

      def create
        # TODO: transactionの整合性確認
        ActiveRecord::Base.transaction do
          session_options_skip
          @task = Task.new(title: params[:title], description: params[:description], user_id: @current_api_v1_user.id, priority: params[:priority], status: params[:status], deadline: params[:deadline])
          @task.save!

          # TODO: 重複を許さないように
          params[:taggings].each do |t|
            tagging = Tagging.new(task_id: @task.id, tag_id: t[:tag_id])
            tagging.save!
          end
          render 'create', status: :ok
        end
      end

      def show
        session_options_skip
        if @task.user_id == @current_api_v1_user.id
          render 'show', status: :ok
        else
          render 'show', status: :unauthorized
        end
      end

      def update
        # TODO: transactionの整合性確認
        ActiveRecord::Base.transaction do
          if @task.user_id == @current_api_v1_user.id
            if @task.update!(task_params)
              # TODO: リファクタ
              @tagging.destroy_all
              params[:taggings].each do |t|
                tagging = Tagging.new(task_id: @task.id, tag_id: t[:tag_id])
                tagging.save!
              end
              render 'update', status: :ok
            else
              render 'update', status: :bad_request
            end
          else
            render 'update', status: :unauthorized
          end
        end
      end

      def destroy
        session_options_skip
        if @task.user_id == @current_api_v1_user.id
          if @task.destroy
            render 'destroy', status: :ok
          else
            render 'destroy', status: :internal_server_error
          end
        else
          render 'destroy', status: :unauthorized
        end
      end

      private
      def set_task
        session_options_skip
        @task = Task.find(params[:id])
        @tagging = Tagging.where(task_id: params[:id])
      end

      def task_params
        params.permit(:title, :description, :priority, :status, :deadline, :taggings)
      end

      def set_page_params
        @now_page = params[:page]? params[:page].to_i : DEFAULT_PAGE
        @status = params[:status]? params[:status] : 'all'
        @priority = params[:priority]? params[:priority] : 'all'
        @sort = params[:sort]? params[:sort] : 'created_at'
        @order = params[:order]? params[:order] : 'desc'
      end

    end
  end
end
