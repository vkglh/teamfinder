class HomeController < ApplicationController

  def index
    render 'home' if current_user
  end

  def user
    render json: current_user
  end

end
