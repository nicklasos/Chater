class PrivateController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @message = Message.new
    @chat_messages = Message.where("(user_id = ? AND to_user_id = ?) OR (user_id = ? AND to_user_id = ?)", 
      params[:id], current_user.id, current_user.id, params[:id]).order("id DESC").limit(10).reverse
  end

  def create
    params[:message][:user_id] = current_user.id
    @message = Message.create(params[:message])

    if @message.valid?

      message = {:channel => "/private/#{params[:message][:user_id]}",
          :data => { :message => CGI.escapeHTML(@message.message), :name => @message.user.email, :time => @message.created_at.strftime("%H:%M")}
      }

      uri = URI.parse("http://localhost:9292/faye")
      Net::HTTP.post_form(uri, :message => message.to_json)
    
      render :partial => "create.js"
    else
      render :nothing => true
    end
  end

  def history
    @user = User.find(params[:id])
    @chat_messages = Message.where("(user_id = ? AND to_user_id = ?) OR (user_id = ? AND to_user_id = ?)", 
      params[:id], current_user.id, current_user.id, params[:id]).order("id ASC")
  end
end
