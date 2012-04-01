class PrivateController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @message = Message.new
    @chat_messages = Message.where("(user_id = ? AND to_user_id = ?) OR (user_id = ? AND to_user_id = ?)", 
      params[:id], current_user.id, current_user.id, params[:id]).order("id ASC")
  end

  def create
    @message = Message.create(
      :user_id => current_user.id,
      :to_user_id => params[:message][:to_user_id],
      :message => params[:message][:message])


  end
end
