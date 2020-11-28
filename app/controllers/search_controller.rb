class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def albums
    render json: []
  end
end
