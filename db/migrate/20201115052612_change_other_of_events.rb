class ChangeOtherOfEvents < ActiveRecord::Migration[5.2]
  def up
    change_column :events, :other, :boolean, default: false
  end
  
  def down
    change_column :events, :other, :boolean
  end
end
