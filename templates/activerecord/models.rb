class Post < ActiveRecord::Base
  validates :title, :body, :presence => true

  attr_accessible :title, :body
end
