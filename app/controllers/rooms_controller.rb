class RoomsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def create
    @room = Room.new(params[:room])

    if @room.save
      redirect_to @room, notice: 'New room was successfully created'
    else
      redirect_to root_url, alert: 'Error'
    end
  end
end
