class CreateTaggings < ActiveRecord::Migration[7.0]
  def up
    create_table :taggings do |t|
      t.references :tag, null: false, foreign_key: true, on_delete: :cascade
      t.references :task, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end

    add_index :taggings, [:tag_id, :task_id], unique: true
  end

  def down
    remove_index :taggings, [:tag_id, :task_id]
    drop_table :taggings
  end
end
