require "http"

class Api::ChallongesController < ApplicationController
  def update
    challonge_data =  JSON.parse(HTTP.get("https://api.challonge.com/v1/tournaments/#{params[:title]}.json", :params => {:api_key => ENV["CHALLONGE_KEY"], include_participants: 1, include_matches: 1}).to_s)
    parse_challonge(challonge_data)
  end
end
