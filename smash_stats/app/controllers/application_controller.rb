class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :parse_challonge
  SPONSORS = [ "ESE", "NP", "HT", "ID", "3G", "BoA", "VAG", "STR", "PL"]

  def parse_challonge(data)
    tournament = Tournament.find_by_title(data["tournament"]["name"])
    unless tournament
      tournament = Tournament.new(title: data["tournament"]["name"], event_time: data["tournament"]["started_at"])
      tournament.save
    end
    participants = create_participant_hash(data["tournament"]["participants"])
    data["tournament"]["matches"].each do |match_hash|

      player1 = match_hash["match"]["player1_id"]
      player2 = match_hash["match"]["player2_id"]
      player1 = participants[player1]
      player2 = participants[player2]
      player1 = normalize_name(player1)
      player2 = normalize_name(player2)
      player1 = find_name(player1)
      player2 = find_name(player2)
      score = match_hash["match"]["scores_csv"]
      player1_games, player2_games = score.split("-")
      match = Match.new(tournament_id: tournament.id, player1_id: player1.id, player2_id: player2.id, player1_games_won: player1_games.to_i, player2_games_won: player2_games.to_i)
      match.save
    end
    tournament.update_skill
  end

  def create_participant_hash(participants)
    participant_hash = {}
    participants.each do |participant|
      participant_hash[participant["participant"]["id"]] = participant["participant"]["name"]
    end
    participant_hash
  end

  def normalize_name(name)
    name = compare_against_sponsor_list(name)
    shed_sponsor = name.split("|")
    name = shed_sponsor.last if shed_sponsor.length > 1
    shed_sponsor = name.split(" l ")
    name = shed_sponsor.last if shed_sponsor.length > 1
    name.split.map{|word| word[0]=word[0].upcase; word}.join(" ")
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

  def compare_against_sponsor_list(name)
    SPONSORS.each do |sponsor|
      if sponsor == name[0...sponsor.length]
        name = name[sponsor.length..-1]
      end
    end
    name
  end


end
