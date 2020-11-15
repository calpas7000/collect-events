class AddDetailsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :geme_title, :string
    add_column :events, :entry, :string
  end
end
