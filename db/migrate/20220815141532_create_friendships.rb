class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, foreign_key: {to_table: :users}
      t.belongs_to :friend, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
