class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :position
      t.string :table_name

      t.timestamps
    end
  end
end
