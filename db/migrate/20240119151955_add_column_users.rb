class AddColumnUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :introduction, :text
  end

  def down
    remove_column :users, :introduction, :text
  end
end
