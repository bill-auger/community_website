class Poll < ActiveRecord::Base
  has_many   :poll_options
  has_many   :votes , :dependent => :destroy
  belongs_to :user
  belongs_to :project

  validates_associated :user
  validates :topic   , :presence => true
  validates :user_id , :presence => true
  validates :user    , :presence => true

  accepts_nested_attributes_for :poll_options , :reject_if => :all_blank , :allow_destroy => true
end
