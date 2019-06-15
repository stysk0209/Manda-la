class RenameTitreColumnToActivities < ActiveRecord::Migration[5.2]
  def change

  	rename_column :activities, :activity, :target

  end
end
