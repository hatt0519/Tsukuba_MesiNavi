class CreateCategoryOthers < ActiveRecord::Migration[5.0]
  def change
    create_table :category_others do |t|
      t.integer :shop_id
      t.string :name

      t.timestamps
    end
  end
end
