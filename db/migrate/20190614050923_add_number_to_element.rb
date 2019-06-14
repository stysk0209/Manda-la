class AddNumberToElement < ActiveRecord::Migration[5.2]
  def change
    add_column :elements, :number, :integer
  end
end
