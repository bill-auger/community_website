class Project < ActiveRecord::Base
  validates :name , uniqueness: { case_sensitive: false } , :presence    => true
  validates :repo , uniqueness: { case_sensitive: false } , :allow_blank => true
end
