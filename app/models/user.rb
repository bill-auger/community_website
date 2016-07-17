class User < ActiveRecord::Base
  validates :nick , :uniqueness => { case_sensitive: false } , :presence => true
  validates :uid  , :uniqueness => { case_sensitive: false } , :presence => true


  def self.find_or_create_with_omniauth auth_hash
    auth_hash[:uid] = "developer-#{Time.now.to_i}" if auth_hash[:provider] == 'developer'

    nick = auth_hash[:info][:name]
    uid  = auth_hash[:uid]

    self.find_or_create_by! :nick => nick do | a_user |
      a_user.nick = nick
      a_user.uid  = uid
    end
  end

end
