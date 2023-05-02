class CreateDiaries < ActiveRecord::Migration[7.0]
  def up
    create_table :diaries do |t|
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      t.string :title
      t.text :content
      t.boolean :public, null: false, :default => false
      t.date :date
      t.timestamps
    end
  end

  def down
    drop_table :diaries
  end
end
