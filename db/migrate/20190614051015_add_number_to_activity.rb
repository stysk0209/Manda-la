class AddNumberToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :number, :integer
  end
end
