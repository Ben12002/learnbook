class AddReferenceToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :category, foreign_key: { to_table: :categories }
  end
end
