class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.float :skill, default: 1200
      t.integer :wins, default: 0
      t.integer :losses, default: 0
      t.timestamps null: false
    end
  end
end
