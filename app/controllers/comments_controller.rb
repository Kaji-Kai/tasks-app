class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:index, :new, :create]
  before_action :set_comment, only: [:edit, :update, :destroy]

  # GET /tasks/:task_id/comments
  # GET /comments
  def index
    @comments = if params[:task_id]
                  @task.comments.order(created_at: :asc)
                else
                  current_user.comments.includes(task: :project)
                end

  end

  def new
    @comment = @task.comments.build
  end

  def create
    @task = current_user.owned_tasks.find(params[:task_id])
    @comment = @task.comments.build(comment_params.merge(owner: current_user, task: Task.find(params[:task_id])))

    if @comment.save
      redirect_to task_path(@task), notice: "Comment added!"
    else
      @comments = @task.comments.order(created_at: :desc)
      render "tasks/show", status: :unprocessable_entity
    end
end
  # GET /comments/:id/edit
  def edit
  end

  # PATCH /comments/:id
  def update
    if @comment.update(content: params[:comment][:content])
      redirect_to comment_path(@comment), notice: "Comment updated"
    else
      render :edit
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment.destroy!
    redirect_to comments_path, notice: "Comment deleted"
  end

  private

  def set_task
    @task = Task.find_by(id: params[:task_id]) if params[:task_id]
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
