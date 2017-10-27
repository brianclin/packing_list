class CreateWeathers < ActiveRecord::Migration[5.1]
  def change
    create_table :weathers do |t|
      t.string :weather

      t.timestamps
    end
  end
end
