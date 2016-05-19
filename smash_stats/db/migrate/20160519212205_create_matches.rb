class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :tournament_id, null: false
      t.integer :player1_id, null: false
      t.integer :player2_id, null: false
      t.integer :player1_games_won, null: false
      t.integer :player2_games_won, null: false
      t.timestamps null: false
    end
    add_index :matches, :tournament_id
    add_index :matches, :player1_id
    add_index :matches, :player2_id
  end
end
