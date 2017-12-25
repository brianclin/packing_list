class AddDomesticToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :domestic, :boolean
  end
end
