class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :headline, null: false
      t.text  :body, null: false
      t.timestamps null: false
    end
  end
end
