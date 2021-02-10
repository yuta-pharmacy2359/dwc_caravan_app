class CreateBlogcomments < ActiveRecord::Migration[5.2]
  def change
    create_table :blogcomments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :blog_id

      t.timestamps
    end
  end
end
