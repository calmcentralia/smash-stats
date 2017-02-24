Rating = Struct.new(:rating, :rating_deviation, :volatility, :id)

class Tournament < ActiveRecord::Base
  has_many :matches, dependent: :destroy
  has_many :home_players, through: :matches
  has_many :away_players, through: :matches
  def update_skill
    rating_identifier = {}
    season_rating_identifier = {}
    all_players = self.home_players.union(self.away_players)
    all_players.each do |player|
      #rating_identifier[player.id] = Rating.new(player.skill, player.rating_deviation, player.volatility, player.id)
      season_rating_identifier[player.id] = Rating.new(player.season_skill, player.season_rating_deviation, player.season_volatility, player.id)
    end
    #period = Glicko2::RatingPeriod.from_objs(rating_identifier.values)
    season_period = Glicko2::RatingPeriod.from_objs(season_rating_identifier.values)

    self.matches.each do |match|
      unless match.player1_games_won == -1 || match.player2_games_won == -1
        if match.player1_games_won > match.player2_games_won
          season_period.game([season_rating_identifier[match.player1_id], season_rating_identifier[match.player2_id]], [1,2])
          #period.game([rating_identifier[match.player1_id], rating_identifier[match.player2_id]], [1,2])
        else
          season_period.game([season_rating_identifier[match.player2_id], season_rating_identifier[match.player1_id]], [1,2])
          #period.game([rating_identifier[match.player2_id], rating_identifier[match.player1_id]], [1,2])
        end
      end
    end
    #next_period = period.generate_next
    season_next_period = season_period.generate_next
    #next_period.players.each { |person| person.update_obj }
    season_next_period.players.each { |person| person.update_obj }
    all_players.each do |player|
      #updated_player = rating_identifier[player.id]
      season_updated_player = season_rating_identifier[player.id]
      #add this back
      #skill: updated_player.rating, rating_deviation: updated_player.rating_deviation, volatility: updated_player.volatility,
      player.update_attributes( season_skill: season_updated_player.rating, season_rating_deviation: season_updated_player.rating_deviation, season_volatility: season_updated_player.volatility)
    end
  end
end
