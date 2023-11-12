### db/migrate/20150127115017_create_comments.rb ###

class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.text    :body
      t.string  :author
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
