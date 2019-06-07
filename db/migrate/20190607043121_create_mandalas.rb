class CreateMandalas < ActiveRecord::Migration[5.2]
  def change
    create_table :mandalas do |t|
      t.integer :user_id
      t.string :target

      t.timestamps
    end
  end
end
