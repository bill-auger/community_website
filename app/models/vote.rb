class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll
  belongs_to :poll_option

  validates_associated :user
  validates_associated :poll
  validates_associated :poll_option
  validates :user_id        , :presence => true
  validates :user           , :presence => true
  validates :poll_id        , :presence => true
  validates :poll           , :presence => true
  validates :poll_option_id , :presence => true
  validates :poll_option    , :presence => true
end
