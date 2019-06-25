class TasksController < ApplicationController


	def create
		@task_new = Task.new(task_params)
		unless @task_new.save
			flash.now[:errors] = @task_new.errors.full_messages
		end
		@tasks = Task.where(user_id: current_user.id, done: false)
		if params[:ajax]
			render partial: 'users/todo_content', locals: { :tasks => @tasks }, :layout => false
		else
			render 'todo'
		end
	end

	def done
		task = Task.find(params[:id])
		task.update(done: true)
		point = Point.new(user_id: current_user.id, element_id: task.element_id)
		point.save!
		@tasks = Task.where(user_id: current_user.id, done: false)
		render 'todo'
	end


	def destroy
		task = Task.find(params[:id])
		task.destroy
		@tasks = Task.where(user_id: current_user.id, done: false)
		render 'todo'
	end



	private

	def task_params
		params.require(:task).permit(:user_id, :element_id, :content, :limit, :done)
	end

end
