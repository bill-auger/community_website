class Project < ActiveRecord::Base
  belongs_to :user
  validates :name , uniqueness: { case_sensitive: false } , :presence    => true
  validates :repo , uniqueness: { case_sensitive: false } , :allow_blank => true
  validates_associated :user
end
