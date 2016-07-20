class Project < ActiveRecord::Base
  belongs_to :user
  validates_associated :user

  validates :name    , uniqueness: { case_sensitive: false } , :presence    => true
  validates :repo    , uniqueness: { case_sensitive: false } , :allow_blank => true
  validates :user_id ,                                         :presence => true
  validates :user    ,                                         :presence => true
end
