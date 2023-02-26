class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.integer :priority
      t.integer :status
      t.datetime :deadline

      t.timestamps
    end
  end
end
