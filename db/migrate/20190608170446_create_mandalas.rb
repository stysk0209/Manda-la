class CreateMandalas < ActiveRecord::Migration[5.2]
  def change
    create_table :mandalas, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :user_id
      t.integer :parent_id
      t.string :target
      t.boolean :achieved, default: false

      t.timestamps
    end
  end
end
