class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:index, :new, :create ]      # nested index
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @project ? @project.tasks.order(created_at: :desc) : current_user.owned_tasks.order(created_at: :desc)
  end

  def new
    @task = @project.tasks.build
  end

  def create
    @task = @project.tasks.build(task_params.merge(owner: current_user, done: 0))
    if @task.save
      redirect_to task_path(@task), notice: "Task created."
    else
      render :new
    end
  end

  def show
    @comments = @task.comments.order(created_at: :desc)
    @comment = @task.comments.build
  end

  def edit

  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "Task updated!"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy!
    redirect_to (@project ? project_tasks_path(@project) : tasks_path), notice: "Task deleted."
  end


  private

  def set_project
    return unless params[:project_id]
    @project = current_user.projects.find(params[:project_id])
  end
  def set_task
    @task = current_user.owned_tasks.find(params[:id])
    @project ||= @task.project
  end

  def task_params
    params.require(:task).permit(:title, :description, :start_date, :due_date, :priority, :done)
  end
end
