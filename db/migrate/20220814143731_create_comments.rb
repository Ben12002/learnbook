class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :creator, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
