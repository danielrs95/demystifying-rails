class Post
  attr_reader :id, :title, :body, :author, :created_at

  def initialize(attributes = {})
    @id = attributes['id']
    @title = attributes['title']
    @body =  attributes['body']
    @author = attributes['author']
    @created_at = attributes['created_at']
  end
end
