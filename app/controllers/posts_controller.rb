class PostsController < ApplicationController
  def show # <- used to be: shown_post
    @post = Post.find(params['id'])
    @comment = Comment.new
  end
end
