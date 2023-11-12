### db/migrate/20150127114820_create_posts.rb ###

class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text   :body
      t.string :author

      t.timestamps null: false
    end
  end
end
