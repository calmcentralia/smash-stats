require "http"

class Api::ChallongeController < ApplicationController
  def create
  challonge_data =  HTTP.get("https://api.challonge.com/v1/tournaments/#{params[:url]}", :params => {:api_key => CHALLONGE_KEY, include_particpants: 1, include_matches: 1})
  end
end
