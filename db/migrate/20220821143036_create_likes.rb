class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.references :liker, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
