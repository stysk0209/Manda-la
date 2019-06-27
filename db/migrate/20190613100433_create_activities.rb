class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :element_id
      t.string :activity

      t.timestamps
    end
  end
end
