class Room < ActiveRecord::Base
  validates :name, :length => { :in => 1..50 }

  before_validation :strip_blanks

  protected

  def strip_blanks
    self.name = self.name.strip
  end
end
