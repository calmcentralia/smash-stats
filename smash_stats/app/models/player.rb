class Player < ActiveRecord::Base
  has_many :names

  has_many :home_matches,
  foreign_key: :player1_id,
  class_name: "Match"

  has_many :away_matches,
  foreign_key: :player2_id,
  class_name: "Match"



  def all_matches
    Match.where('player1_id = :player_id OR player2_id = :player_id', player_id: self.id)
  end

  def self.season_reset
    Player.update_all(season_skill: 1500.0, season_volatility: 0.06, season_rating_deviation: 350.0)
  end

  def self.season_list
    Player.joins(:names).order(season_skill: :desc).select("players.*, names.tag")
    .where("players.season_rating_deviation < 100")
    .each {|player| puts player.tag; puts player.season_skill}
  end

end
