class Api::PlayersController < ApplicationController

  def index
    render json: Player.order(:skill)
  end

  def show
    @player = Player.find_by_id(params[:id])
    if @player
      render: :show
    else
      render json: {errors: "player doesn't exist" }, status: 422
    end
  end
end
