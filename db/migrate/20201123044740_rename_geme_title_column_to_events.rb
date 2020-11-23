class RenameGemeTitleColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :geme_title, :game_title
  end
end
