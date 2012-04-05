class RoomsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @room_messages = Message.where("room_id = ?", params[:id]).order("id DESC").limit(10).includes(:user).reverse
  end

  def create_message
    params[:message][:user_id] = current_user.id
    @message = Message.create(params[:message])

    if @message.valid?
      Message.broadcast({
        message: @message,
        type: "rooms",
        id: params[:message][:room_id],
        broadcast_uri: request.host
      })

      render :partial => "ok.js"
    else
      render :nothing => true
    end
  end

  def create
    @room = Room.create(params[:room])

    if @room.valid?
      redirect_to @room, notice: 'New room was successfully created'
    else
      redirect_to root_url, alert: 'Enter room name'
    end
  end

  def history
    @room = Room.find(params[:id])
    @room_messages = Message.where("room_id = ?", params[:id]).includes(:user)
  end
end
