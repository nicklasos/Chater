class RoomController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def private

    redirect_to root_url, alert: "You can`t chat to yourself :(" if current_user.id == params[:id].to_i
  end

  def group
  end
end
