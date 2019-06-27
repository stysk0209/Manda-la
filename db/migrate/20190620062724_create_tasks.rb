class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :user_id
      t.integer :element_id
      t.text :content
      t.date :limit
      t.boolean :done

      t.timestamps
    end
  end
end
