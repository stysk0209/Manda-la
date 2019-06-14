class AddNumberToMandala < ActiveRecord::Migration[5.2]
  def change
    add_column :mandalas, :number, :integer
  end
end
