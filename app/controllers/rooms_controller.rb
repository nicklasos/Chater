class RoomsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @room_messages = Message.where("room_id = ?", params[:id])
  end

  def create_message
    params[:message][:user_id] = current_user.id
    @message = Message.create(params[:message])

    if @message.valid?
      message = {:channel => "/rooms/#{params[:message][:room_id]}",
          :data => { :message => CGI.escapeHTML(@message.message), :name => @message.user.email, :time => @message.created_at.strftime("%H:%M")}
      }

      uri = URI.parse("http://localhost:9292/faye")
      Net::HTTP.post_form(uri, :message => message.to_json)

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
end
