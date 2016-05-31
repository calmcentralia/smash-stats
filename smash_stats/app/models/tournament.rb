class Tournament < ActiveRecord::Base
  has_many :matches
  has_many :home_players, through: :matches
  has_many :away_players, through: :matches
  Rating = Struct.new(:rating, :rating_deviation, :volatility)
  def update_skill
    rating_identifier = {}
    all_players = self.home_players.union(self.away_players)

    all_players.each do |player|
      rating_identifier[player.id] = Rating.new(player.skill, player.rating_deviation, player.volatility)
    end
    period = Glicko2::RatingPeriod.from_objs rating_identifier.values

    self.matches.each do |match|
      unless match.player1_games_won == -1 || match.player2_games_won == -1
        victor = []
        victor = match.player1_games_won > match.player2_games_won ? [1,2] : [2,1]
        period.game([rating_identifier[match.player1_id], rating_identifier[match.player2_id]], victor)
      end
    end
    next_period = period.generate_next
    next_period.players.each { |p| p.update_obj }
    all_players.each do |player|
      updated_player = rating_identifier[player.id]
      player.update(rating: updated_player.rating, rating_deviation: updated_player.rating_deviation, volatility: updated_player.volatility)
    end
  end
end
