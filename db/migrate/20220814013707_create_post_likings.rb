class CreatePostLikings < ActiveRecord::Migration[7.0]
  def change
    create_table :post_likings do |t|
      t.belongs_to :liker, foreign_key: {to_table: :users}
      t.belongs_to :liked_post, foreign_key: {to_table: :posts}
      t.timestamps
    end
  end
end
