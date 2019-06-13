class CreateElements < ActiveRecord::Migration[5.2]
  def change
    create_table :elements do |t|
      t.integer :mandala_id
      t.string :element

      t.timestamps
    end
  end
end
