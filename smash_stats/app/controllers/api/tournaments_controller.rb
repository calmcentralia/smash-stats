class Api::TournamentsController < ApplicationController
  def index
    render json: Tournament.order(:event_time)
  end
end
