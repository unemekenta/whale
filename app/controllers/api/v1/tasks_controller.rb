module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :update, :destroy]
      before_action :authenticate_api_v1_user!
      include ReturnData

      def index
        session_options_skip
        tasks = Task.where(user_id: @current_api_v1_user.id)
        return_data(STATUS_SUCCESS, '', tasks)
      end

      def create
        session_options_skip
        user = User.find_by(email: params[:uid])
        task = Task.new(title: params[:title], description: params[:description], user_id: user.id)
        task.save
        return_data(STATUS_SUCCESS, '', task)
      end

      def show
        session_options_skip
        return_data(STATUS_SUCCESS, '', @task)
      end

      def update
        session_options_skip
        if @task.update(task_params)
          return_data(STATUS_SUCCESS, 'Updated the task', @task)
        else
          return_data(STATUS_SUCCESS, 'Not updated', @task.errors)
        end
      end

      def destroy
        session_options_skip
        @task.destroy
        return_data(STATUS_SUCCESS, 'Deleted the task', @task)
      end

      private
      def set_task
        session_options_skip
        @task = Task.find(params[:id])
      end

      def task_params
        params.permit(:title, :description)
      end
    end
  end
end
