class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.belongs_to :sender, class_name: "User"
      t.belongs_to :receiver, class_name: "User"
      t.timestamps
    end
  end
end
