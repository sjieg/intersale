class CreateCollectionItems < ActiveRecord::Migration[7.1]
  def change
    create_table :collection_items do |t|
      t.references :collection, null: false, foreign_key: true
      t.string :title, null: false, index: true
      t.text :description
      t.integer :value
      t.integer :height_mm
      t.integer :width_mm
      t.integer :depth_mm
      t.integer :availability, default: 0, null: false, index: true

      t.timestamps
    end
  end
end
