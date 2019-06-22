class TasksController < ApplicationController


	def create
		@task_new = Task.new(task_params)
		unless @task_new.save
			flash.now[:errors] = @task_new.errors.full_messages
		end
		# redirect_to user_path(current_user)
		@tasks = Task.where(user_id: current_user.id, done: false)
		render 'todo'
	end

	def done
		task = Task.find(params[:id])
		task.update(done: true)
		point = Point.new(element_id: task.element_id)
		point.save!
		render 'todo'
	end


	def destroy
		task = Task.find(params[:id])
		task.destroy
		render 'todo'
	end



	private

	def task_params
		params.require(:task).permit(:user_id, :element_id, :content, :limit, :done)
	end

end
