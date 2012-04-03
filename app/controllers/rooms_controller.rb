class RoomsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @room_messages = Message.where("room_id = ?", params[:id])
  end

  def create_message
    @message = Message.create(
      :user_id => current_user.id,
      :message => params[:message][:message],
      :room_id => params[:message][:room_id])

      render :partial => "private/create.js"
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
