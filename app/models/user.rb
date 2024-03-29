class User < ActiveRecord::Base
  has_many :messages  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else
      User.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
    end
  end
  
end
