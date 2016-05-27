class Tournament < ActiveRecord::Base
  has_many :matches
  has_many :home_players, through: :matches
  has_many :away_players, through: :matches
  def update_skill
    all_players = self.home_players.union(self.away_players)
    all_players.each do |player|
      matches_for_player = player.all_matches
      matches_for_player.each do |match|
        score = nil
        if player.id == match.player1_id
          if match.player1_games_won > match.player2_games_won
            score = 1
          else
            score = 0
          end
        else
          if match.player2_games_won > match.player1_games_won
            score = 1
          else
            score = 0
          end
        end
      end
    end
  end

  def players
  end
end
