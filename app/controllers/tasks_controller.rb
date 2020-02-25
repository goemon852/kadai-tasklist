class TasksController < ApplicationController
    
    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy, :show, :edit]
    
    def index
        @tasks = current_user.tasks.order(id: :desc)
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = current_user.tasks.build  # form_with 用
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:notice] = "タスクが正常に追加されました"
            redirect_to root_path
        else
            flash[:notice] = "タスクが追加されませんでした"
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:notice] = "タスクが正常に更新されました"
            redirect_to root_path
        else
            flash[:notice] = "タスクが更新されませんでした"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        flash[:notice] = 'タスクが正常に削除されました'
        redirect_to root_path
    end
    
    private

    #Strong Parameter
    def task_params
        params.require(:task).permit(:content, :status) 
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_path
        end
    end    
    
end