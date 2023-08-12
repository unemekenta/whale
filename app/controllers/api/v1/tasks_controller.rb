module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!
      include ApiResponse

      def index
        session_options_skip
        tasks = Task.where(user_id: @current_api_v1_user.id).limit(INDEX_LIMIT).offset(params[:offset])
        return_data('', JSON.parse(task_res_fmt(tasks)))
      end

      def create
        ActiveRecord::Base.transaction do
          session_options_skip
          user = User.find_by(email: params[:uid])
          task = Task.new(title: params[:title], description: params[:description], user_id: user.id, priority: params[:priority], status: params[:status], deadline: params[:deadline])
          task.save

          # TODO: 重複を許さないように
          params[:taggings].each do |t|
            tagging = Tagging.new(task_id: task.id, tag_id: t[:tag_id])
            tagging.save
          end
          return_data('', task)
        end
      end

      def show
        session_options_skip
        if @task.user_id == @current_api_v1_user.id
          return_data('', JSON.parse(task_res_fmt(@task)))
        else
          return_error('You are not authorized to delete this task', '')
        end
      end

      def update
        ActiveRecord::Base.transaction do
          if @task.user_id == @current_api_v1_user.id
            if @task.update(task_params)
              # TODO: リファクタ
              @tagging.destroy_all
              params[:taggings].each do |t|
                tagging = Tagging.new(task_id: @task.id, tag_id: t[:tag_id])
                tagging.save
              end
              return_data('Updated the task', @task)
            else
              return_error('Not updated', @task.errors)
            end
          else
            return_error('You are not authorized to update this task', '')
          end
        end
      end

      def destroy
        session_options_skip
        if @task.user_id == @current_api_v1_user.id
          @task.destroy
          return_data('Deleted the task', @task)
        else
          return_error('You are not authorized to delete this task', '')
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

      def task_res_fmt(task)
        task.to_json(include: [:tags, user: {only: [:id, :nickname, :image]}, taggings:{only: [:tag_id]}, comments: {include: {user: {only: [:id, :nickname, :image]}}}], except: [:created_at, :user_id])
      end

    end
  end
end
