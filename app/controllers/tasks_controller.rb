class TasksController < ApplicationController
	before_action :find_task, only: [:show, :edit, :update, :destroy] 

	def index
		if params[:category].blank?
			@tasks = Task.all.order("DATE(created_at) DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@tasks = Task.where(:category_id => @category_id).order("created_at DESC")
		end
	end

	def new 
		@task = current_user.tasks.build
		@categories = Category.all.map{ |t| [t.name, t.id] }
	end 

	def create
		@task = current_user.tasks.build(task_params)
		@task.category_id = params[:category_id]

		if @task.save
			redirect_to root_path
		else
			render 'new'
		end 
	end

	def show
		@task = Task.find(params[:id]) 
	end

	def update
		@task.category_id = params[:category_id]
		@task.category_id = params[:category_id]
		if @task.update(task_params)
			redirect_to task_path(@task)
		else
			render 'edit'
		end 

	end

	def edit
		@categories = Category.all.map{|c| [c.name, c.id]}
	end

	def destroy
		@task.destroy
		redirect_to root_path
	end
		

	private


	def task_params
		params.require(:task).permit(:title, :description, :deadline, :category_id)
	end 

	def find_task
		@task = Task.find(params[:id]) 
	end
end
