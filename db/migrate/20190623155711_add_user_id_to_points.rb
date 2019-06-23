class AddUserIdToPoints < ActiveRecord::Migration[5.2]
  def change
    add_column :points, :user_id, :integer, after: :element_id
  end
end
