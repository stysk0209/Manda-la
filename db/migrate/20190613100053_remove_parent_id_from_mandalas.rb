class RemoveParentIdFromMandalas < ActiveRecord::Migration[5.2]
  def change
    remove_column :mandalas, :parent_id, :integer
  end
end
