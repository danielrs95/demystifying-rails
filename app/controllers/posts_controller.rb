class PostsController < ApplicationController
  def show # <- used to be: shown_post
    @post = Post.find(params['id'])
    @comment = Comment.new

    render 'application/show_post'
  end
end
