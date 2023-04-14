class CreateTags < ActiveRecord::Migration[7.0]
  def up
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    add_index :tags, :name
  end

  def down
    drop_table :tags
    remove_index :tags, :name
  end
end
