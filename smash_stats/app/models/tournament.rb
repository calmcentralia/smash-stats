class Tournament < ActiveRecord::Base
  has_many :matches
  has_many :players, through: :matches
  has_many :away_players, through: :matches
  def update_skill
    self.players
  end
end
