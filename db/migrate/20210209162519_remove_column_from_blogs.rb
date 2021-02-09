class RemoveColumnFromBlogs < ActiveRecord::Migration[5.2]
  def up
    remove_column :blogs, :blogimage
  end
  def down
    add_column :blogs, :blogimage, :string
  end
end
