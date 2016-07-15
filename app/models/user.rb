class User < ActiveRecord::Base
  validates :nick , uniqueness: { case_sensitive: false } , :presence => true
end
