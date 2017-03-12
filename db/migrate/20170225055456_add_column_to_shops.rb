class AddColumnToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :uid, :string
  end
end
