class TasksController < ApplicationController


	def create
		@task_new = Task.new(task_params)
		unless @task_new.save
			flash[:errors] = @task_new.errors.full_messages
		end
		redirect_to user_path(current_user)
	end

	def done
		task = Task.find(params[:id])
		task.update(done: true)
		point = Point.new(element_id: task.element_id)
		point.save!
		redirect_to user_path(current_user.id)
	end


	def destroy
		task = Task.find(params[:id])
		task.destroy
		redirect_to user_path(current_user.id)
	end



	private

	def task_params
		params.require(:task).permit(:user_id, :element_id, :content, :limit, :done)
	end

end
