class CreateCategoriesOwnedByShops < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_owned_by_shops do |t|
      t.integer :shop_id
      t.integer :category_id
      t.string :category_other
      t.timestamps
    end
  end
end
