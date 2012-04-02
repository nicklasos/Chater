class HomeController < ApplicationController

  def index
    @users = User.all
    @room = Room.new
    @rooms = Room.all
  end 
end
