class AddDefaultPointToPoints < ActiveRecord::Migration[5.2]
  def change

  	change_column :points, :point, :integer, :default => 1

  end
end
