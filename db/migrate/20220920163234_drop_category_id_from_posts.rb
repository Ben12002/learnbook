class DropCategoryIdFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :category_id
  end
end
