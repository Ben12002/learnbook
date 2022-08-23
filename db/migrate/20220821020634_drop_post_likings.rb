class DropPostLikings < ActiveRecord::Migration[7.0]
  def change
    drop_table :post_likings
  end
end
