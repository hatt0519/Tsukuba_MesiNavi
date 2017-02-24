class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :user_name
      t.string :avatar_url
      t.timestamps
    end
    add_index :users, [:uid, :provider], unique: true
  end
end
