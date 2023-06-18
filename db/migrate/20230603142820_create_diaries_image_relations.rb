class CreateDiariesImageRelations < ActiveRecord::Migration[7.0]
  def up
    create_table :diaries_image_relations do |t|
      t.references :diary, null: false, foreign_key: { on_delete: :cascade }
      t.references :image, null: false, foreign_key: true

      t.timestamps
    end
    add_index :diaries_image_relations, [:diary_id, :image_id], unique: true
  end
  def down
    remove_index :diaries_image_relations, [:diary_id, :image_id]
    drop_table :diaries_image_relations
  end
end
