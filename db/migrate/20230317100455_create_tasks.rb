class CreateTasks < ActiveRecord::Migration[7.0]
  def up
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      t.string :title
      t.text :description
      t.integer :priority
      t.integer :status
      t.datetime :deadline

      t.timestamps
    end

  end

  def down
    drop_table :tasks
  end
end
