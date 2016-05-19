class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.integer :player_id, null: false
      t.string :tag, null: false
      t.boolean :desired_tag, null: false
      t.timestamps null: false
    end
    add_index :names, :player_id
  end
end
