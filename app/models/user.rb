class User < ActiveRecord::Base
  has_many :projects
  has_many :polls
  has_many :votes        , :dependent => :destroy
  has_many :poll_options , :through   => :votes

  validates :nick , :uniqueness => { case_sensitive: false } , :presence => true
  validates :uid  , :uniqueness => { case_sensitive: false } , :presence => true


  def self.find_or_create_with_omniauth auth_hash
    # FIXME: we may want not at all to handle developer strategy
    auth_hash[:uid] = "developer-#{Time.now.to_i}" if auth_hash[:provider] == 'developer'

    # sanitize auth hash
    auth_hash                 = {}        unless auth_hash                .is_a? Hash
    auth_hash[:info]          = {}        unless auth_hash[:info]         .is_a? Hash
    auth_hash[:uid ]          = ''        unless auth_hash[:uid ]         .is_a? String
    auth_hash[:info][:name  ] = ''        unless auth_hash[:info][:name  ].is_a? String
    auth_hash[:info][:avatar] = MM_AVATAR unless auth_hash[:info][:avatar].is_a? String

    # normalize params
    uid    =   auth_hash[:uid ]
    nick   = ((auth_hash[:info][:name].match NICK_REGEX) || [])[0]
    avatar =   auth_hash[:info][:avatar]

    self.find_or_create_by! :nick => nick do | a_user |
      a_user.uid    = uid
      a_user.nick   = nick
      a_user.avatar = avatar
    end
  end

end
