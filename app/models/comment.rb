### app/models/comment.rb ###

class Comment < ActiveRecord::Base
  validates_presence_of :body, :author
end

