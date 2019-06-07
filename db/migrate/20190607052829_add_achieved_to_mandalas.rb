class AddAchievedToMandalas < ActiveRecord::Migration[5.2]
  def change
    add_column :mandalas, :achieved, :boolean
  end
end
