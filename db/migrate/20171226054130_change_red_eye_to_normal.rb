class ChangeRedEyeToNormal < ActiveRecord::Migration[5.1]
  def change
    rename_column :items, :redeye, :normal
  end
end
