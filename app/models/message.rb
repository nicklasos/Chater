class Message < ActiveRecord::Base
  belongs_to :user

  before_validation :strip_blanks

  validates :message, :length => { :in => 1..200 }
  validates :user_id, :presence => true

  def self.get_messages(id, user_id, params = {})
    params[:limit] |= false

    query = "(user_id = ? AND to_user_id = ?) OR (user_id = ? AND to_user_id = ?)"

    if params[:limit] == true 
      messages = self.where(query, id, user_id, user_id, id).order("id DESC").limit(10).reverse
    else
      messages = self.where(query, id, user_id, user_id, id).order("id ASC")
    end

    messages
  end

  def self.broadcast(params = {})
    message = {:channel => "/#{params[:type]}/#{params[:id]}",
      :data => {
        :message => CGI.escapeHTML(params[:message].message), 
        :name => params[:message].user.email, 
        :time => params[:message].created_at.strftime("%H:%M")
      }
    }

    uri = URI.parse("http://#{params[:broadcast_uri]}:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  protected

  def strip_blanks
    self.message = self.message.strip
  end
end
