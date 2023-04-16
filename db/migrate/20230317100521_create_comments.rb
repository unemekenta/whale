class CreateComments < ActiveRecord::Migration[7.0]
  def up
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      t.references :task, null: false, foreign_key: true, on_delete: :cascade
      t.text :content

      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
