class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.belongs_to :user, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
