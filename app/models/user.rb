class User < ActiveRecord::Base
  has_many :projects
  validates :nick , :uniqueness => { case_sensitive: false } , :presence => true
  validates :uid  , :uniqueness => { case_sensitive: false } , :presence => true


  def self.find_or_create_with_omniauth auth_hash
    # FIXME: we may want not at all to handle developer strategy
    auth_hash[:uid] = "developer-#{Time.now.to_i}" if auth_hash[:provider] == 'developer'

    # sanitize auth hash
    auth_hash               = {} unless auth_hash              .is_a? Hash
    auth_hash[:info]        = {} unless auth_hash[:info]       .is_a? Hash
    auth_hash[:info][:name] = '' unless auth_hash[:info][:name].is_a? String
    auth_hash[:uid]         = '' unless auth_hash[:uid ]       .is_a? String

    # normalize params
    nick = ((auth_hash[:info][:name].match NICK_REGEX) || [])[0]
    uid  = auth_hash[:uid]

    self.find_or_create_by! :nick => nick do | a_user |
      a_user.nick = nick
      a_user.uid  = uid
    end
  end

end
