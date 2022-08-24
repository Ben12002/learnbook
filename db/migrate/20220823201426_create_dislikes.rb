class CreateDislikes < ActiveRecord::Migration[7.0]
  def change
    create_table :dislikes do |t|
      t.references :dislikeable, polymorphic: true
      t.references :disliker, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
