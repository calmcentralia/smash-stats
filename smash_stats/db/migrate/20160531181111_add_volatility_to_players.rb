class AddVolatilityToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :volatility, :float, default: 0.06
    add_column :players, :rating_deviation, :float, default: 350
    change_column :players, :skill, :float, default: 1500
  end
end
