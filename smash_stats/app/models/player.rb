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
end
