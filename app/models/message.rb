class Message < ActiveRecord::Base
  belongs_to :user

  before_validation :strip_blanks

  validates :message, :length => { :in => 1..200 }
  validates :user_id, :presence => true


  protected

  def strip_blanks
    self.message = self.message.strip
  end
end
