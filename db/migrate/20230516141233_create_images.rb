class CreateImages < ActiveRecord::Migration[7.0]
  def up
    create_table :images do |t|
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      t.string :image, null: false
      t.string :image_content_type
      t.integer :image_file_size
      t.integer :image_type, null: false
      t.string :caption

      t.timestamps
    end
  end

  def down
    drop_table :images
  end
end
