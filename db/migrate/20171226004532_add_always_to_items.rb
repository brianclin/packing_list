class AddAlwaysToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :always, :boolean
  end
end
