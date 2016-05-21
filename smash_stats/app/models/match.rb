class Match < ActiveRecord::Base
  belongs_to :home_player,
    foreign_key: :player1_id,
    class_name: "Player"

  belongs_to :away_player,
    foreign_key: :player2_id,
    class_name: "Player"

  belongs_to :tournament

  def both_players
    Player.where(id: [self.player1_id, self.player2_id])
  end

end
