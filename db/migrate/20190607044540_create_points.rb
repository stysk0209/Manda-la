class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.integer :element_id
      t.integer :point

      t.timestamps
    end
  end
end
