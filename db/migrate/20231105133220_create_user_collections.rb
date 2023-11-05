class CreateUserCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :user_collections do |t|
      t.references :user, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true
      t.integer :role, index: true, null: false, default: 0

      t.timestamps
    end
  end
end
