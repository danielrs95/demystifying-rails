### app/models/comment.rb ###

class Comment < ActiveRecord::Base
  validates_presence_of :body, :author

  belongs_to :post

  after_commit :update_last_commented_on

  private

  def update_last_commented_on
    post.last_commented_on = created_at
    post.save
  end
end
