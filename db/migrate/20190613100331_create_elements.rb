class CreateElements < ActiveRecord::Migration[5.2]
  def change
    create_table :elements, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :mandala_id
      t.string :element

      t.timestamps
    end
  end
end
