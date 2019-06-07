class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.integer :activity_id
      t.integer :point

      t.timestamps
    end
  end
end
