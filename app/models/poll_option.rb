class PollOption < ActiveRecord::Base
  has_many   :votes , :dependent => :destroy
  has_many   :user  , :through   => :votes   , :as => :voters
  belongs_to :poll

  validates_associated :poll
  validates :option  , :presence => true
  validates :poll_id , :presence => true
  validates :poll    , :presence => true
end
