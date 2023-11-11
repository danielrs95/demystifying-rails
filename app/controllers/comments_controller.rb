### app/controllers/comments_controller.rb ###

class CommentsController < ApplicationController
  before_action :find_posts, only: %i[create destroy]

  # def list_comments -> list -> index
  def index
    @comments = Comment.all
  end

  # def create_comment -> create
  def create
    @comment = @post.build_comment('author' => params['author'],
                                   'body' => params['body'])

    if @comment.save
      redirect_to post_path(@post.id)
    else
      render 'posts/show'
    end
  end

  # def delete_comment -> delete -> destroy
  def destroy
    @post.delete_comment(params['id'])

    redirect_to post_path(post.id)
  end

  private

  def find_posts
    @post = Post.find params['post_id']
  end
end
