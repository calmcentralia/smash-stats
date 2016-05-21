class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :title, null: false
      t.datetime :event_time, null: false
      t.text :event_description
      t.timestamps null: false
    end
  end
end
