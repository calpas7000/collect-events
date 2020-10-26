class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :place
      t.date :event_date
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
