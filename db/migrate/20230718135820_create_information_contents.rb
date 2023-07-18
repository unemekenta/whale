class CreateInformationContents < ActiveRecord::Migration[7.0]
  def up
    create_table :information_contents do |t|
      t.string :content, null: false
      t.string :link, null: true
      t.boolean :display_link, null: false, :default => false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.timestamps
    end
  end

  def down
    drop_table :information_contents
  end
end
