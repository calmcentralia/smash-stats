class Api::PlayersController < ApplicationController

  def index
    @players = Player.all
    render :index
  end

  def show
    @player = Player.find_by_id(params[:id])
    if @player
      render :show
    else
      render json: {errors: "player doesn't exist" }, status: 422
    end
  end
end
