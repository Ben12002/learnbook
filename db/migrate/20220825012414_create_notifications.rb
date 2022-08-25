class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :sender, foreign_key: {to_table: :users}
      t.references :receiver, foreign_key: {to_table: :users}
      t.boolean :seen, default: :false
      t.text :message
      t.string :link
      t.timestamps
    end
  end
end
