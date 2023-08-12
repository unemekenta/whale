class RenamePublicColumnToIsPublicInDiaries < ActiveRecord::Migration[7.0]
  def up
    rename_column :diaries, :public, :is_public
  end

  def down
    rename_column :diaries, :is_public, :public
  end
end
