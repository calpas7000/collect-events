class AddPlatformsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :other, :boolean
    add_column :events, :pc, :boolean
    add_column :events, :ps4, :boolean
    add_column :events, :ps5, :boolean
    add_column :events, :xbox_one, :boolean
    add_column :events, :xbox_series_xs, :boolean
    add_column :events, :switch, :boolean
    add_column :events, :smartphone, :boolean
  end
end
