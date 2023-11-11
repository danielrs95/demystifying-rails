### app/models/post.rb ###

class Post < ActiveRecord::Base
  validates_presence_of :title, :body, :author

  has_many :comments
end
