class PrivateController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_same_user

  def show
    @user = User.find(params[:id])
    @message = Message.new
    @chat_messages = Message.get_messages(params[:id], current_user.id, limit: true)
  end

  def create
    params[:message][:user_id] = current_user.id
    @message = Message.create(params[:message])

    if @message.valid?
      Message.broadcast({
        message: @message,
        type: "private",
        id: params[:message][:user_id],
        broadcast_uri: request.host
      })

      Message.broadcast({
        message: @message,
        type: "user",
        id: params[:message][:to_user_id],
        broadcast_uri: request.host
      })
    
      render :partial => "create.js"
    else
      render :nothing => true
    end
  end

  def history
    @user = User.find(params[:id])
    @chat_messages = Message.get_messages(params[:id], current_user.id)
  end

  private

  def check_same_user
    redirect_to root_url, alert: "Forever alone?" if current_user.id == params[:id].to_i
  end
end
