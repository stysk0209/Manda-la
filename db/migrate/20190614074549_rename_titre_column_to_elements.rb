class RenameTitreColumnToElements < ActiveRecord::Migration[5.2]
  def change

	rename_column :elements, :element, :target

  end
end
