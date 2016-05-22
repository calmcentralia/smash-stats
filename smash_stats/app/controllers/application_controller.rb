class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def parse_challonge(data)
    tournament = Tournament.find_by_title(data["tournament"]["name"])
    unless tournament
      tournament = Tournament.new(title: data["tournament"]["name"], event_time: data["tournament"]["started_at"])
      tournament.save
    participants = create_participant_hash(data["tournament"]["participants"])
    data["tournament"]["matches"].each do |match_hash|

      player1 = match_hash["match"]["player1_id"]
      player2 = match_hash["match"]["player2_id"]
      player1 = participants[player1]
      player2 = participants[player2]
      player1 = find_player_by_name(player1)
      player2 = find_player_by_name(player2)
      score = match_hash["match"]["score_csv"]
      player1_games, player2_games = score.split("-")
      match = Match.new(tournament_id: tournament.id, player1_id: player1.id, player2_id: player2.id, player1_games_won: player1_games.to_i, player2_games_won: player2_games.to_i)
      match.save
  end

  def create_participant_hash(participants)
    participant_hash = {}
    participants.each do |participant|
      participant_hash[particpant["participant"]["id"]] = particpant["particpant"]["name"]
    end
    participant_hash
  end

  def update_skill(player1, player2)
  end

  def find_name(player_name)
    name = Name.find_by_tag(player_name)
    if name
      return name.player
    else
      player = Player.new
      player.save
      name = Name.new(player_id: player.id, tag: player_name, desired_tag: true)
      name.save
      player
    end
  end

  def new_player(name)

  end


end
