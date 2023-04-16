class CreateTags < ActiveRecord::Migration[7.0]
  def up
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    add_index :tags, :name
  end

  def down
    remove_index :tags, :name
    drop_table :tags
  end
end
