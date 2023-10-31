### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base
  def hello_world
    render 'application/hello_world'
  end

  def list_posts
    posts = Post.all

    render 'application/list_posts', locals: { posts: posts }
  end

  def show_post
    post = Post.find(params['id'])

    render 'application/show_post', locals: { post: post }
  end

  def new_post
    post = Post.new

    render 'application/new_post', locals: { post: post }
  end

  def create_post
    post = Post.new('title' => params['title'], 'body' => params['body'], 'author' => params['author'])

    if post.save
      redirect_to '/list_posts'
    else
      render 'application/new_post', locals: { post: post }
    end
  end

  def edit_post
    post = Post.find(params['id'])

    render 'application/edit_post', locals: { post: post }
  end

  def update_post
    post = Post.find(params['id'])
    post.set_attributes('title' => params['title'], 'body' => params['body'], 'author' => params['author'])

    if post.save
      redirect_to '/list_posts'
    else
      render 'application/edit_post', locals: { post: post }
    end
  end

  def delete_post
    post = Post.find(params['id'])
    post.destroy

    redirect_to '/list_posts'
  end

  def create_comment
    insert_comment_query = <<-SQL
    INSERT INTO comments (body, author, post_id, created_at)
    VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_comment_query,
                       params['body'],
                       params['author'],
                       params['post_id'],
                       Date.current.to_s

    redirect_to "/show_post/#{params['post_id']}"
  end

  private

  def connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end
end
