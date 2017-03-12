class RemoveColumnFromCategoriesOwnedByShops < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories_owned_by_shops, :category_other
  end
end
