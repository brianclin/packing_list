class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :category_id
      t.integer :event_id
      t.integer :weather_id
      t.integer :transporation_id
      t.boolean :international

      t.timestamps
    end
  end
end
