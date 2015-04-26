class HomeController < ApplicationController

  def index
    render 'home' if current_user
  end

  def user
    render json: current_user
  end

  def timezones
    render json: { zones: Timezone::Zone.names.select {|zone| zone.match params[:term]} }
  end

end
