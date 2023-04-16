class CreateTaggings < ActiveRecord::Migration[7.0]
  def up
    create_table :taggings do |t|
      t.references :tag, null: false, foreign_key: true, on_delete: :cascade
      t.references :task, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end

  def down
    drop_table :taggings
  end
end
