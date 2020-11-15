class ChangeOtherDefaultNullOfEvents < ActiveRecord::Migration[5.2]
  def up
    change_column :events, :other, :boolean, default: false, null: false
    change_column :events, :pc, :boolean, default: false, null: false
    change_column :events, :ps4, :boolean, default: false, null: false
    change_column :events, :ps5, :boolean, default: false, null: false
    change_column :events, :xbox_one, :boolean, default: false, null: false
    change_column :events, :xbox_series_xs, :boolean, default: false, null: false
    change_column :events, :switch, :boolean, default: false, null: false
    change_column :events, :smartphone, :boolean, default: false, null: false
  end
  
  def down
    change_column :events, :other, :boolean, default: true
    change_column :events, :pc, :boolean
    change_column :events, :ps4, :boolean
    change_column :events, :ps5, :boolean
    change_column :events, :xbox_one, :boolean
    change_column :events, :xbox_series_xs, :boolean
    change_column :events, :switch, :boolean
    change_column :events, :smartphone, :boolean
  end
end
