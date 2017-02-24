class AddSeasonSkillToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :season_volatility, :float, default: 0.06
    add_column :players, :season_rating_deviation, :float, default: 350
    add_column :players, :season_skill, :float, default: 1500
  end
end
