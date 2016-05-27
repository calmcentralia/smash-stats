class Api::TournamentsController < ApplicationController
  def index
    if [:parameters][:flag] == "recent"
      @tournament = Tournament.includes(:matches).where(matches: { tournament_id: true}).order(updated_at: :desc)
    else
      @tournament = Tournament.order(:event_time)
    end
    render :index
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      render json: @tournament
    else
      render json: {errors: @tournament.errors.full_messages}, status: 422
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :event_time, :event_description)
  end
end
