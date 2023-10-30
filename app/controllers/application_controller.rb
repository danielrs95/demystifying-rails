### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base
  def hello_world
    render 'application/hello_world'
  end

  def list_posts
    posts = connection.execute('SELECT * FROM posts')

    render 'application/list_posts', locals: { posts: posts }
  end

  def show_post
    post = connection.execute('SELECT * FROM posts WHERE posts.id = ? LIMIT 1', params['id']).first

    render 'application/show_post', locals: { post: post }
  end

  def new_post
    render 'application/new_post'
  end

  def create_post
    insert_query = <<-SQL
      INSERT INTO posts (title, body, author, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query,
                       params['title'],
                       params['body'],
                       params['author'],
                       Date.current.to_s

    redirect_to '/list_posts'
  end

  def edit_post
    post = connection.execute('SELECT * FROM posts WHERE posts.id = ? LIMIT 1', params['id']).first

    render 'application/edit_post', locals: { post: post }
  end

  def update_post
    update_query = <<-SQL
      UPDATE posts
      SET title = ?,
          body = ?,
          authoer = ?,
      WHERE posts.id = ?
    SQL

    connection.execute update_query, params['title'], params['body'], params['author'], params['id']

    redirect_to '/list_posts'
  end

  private

  def connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end
end
