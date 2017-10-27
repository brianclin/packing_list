class CreateTransportations < ActiveRecord::Migration[5.1]
  def change
    create_table :transportations do |t|
      t.string :transportation

      t.timestamps
    end
  end
end
