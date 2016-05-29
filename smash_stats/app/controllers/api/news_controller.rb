class Api::NewsController < ApplicationController
  def index
    render json: News.order(created_at: :desc)
  end
end
