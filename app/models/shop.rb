class Shop < ApplicationRecord
  has_many :categories_owned_by_shop

  validates_uniqueness_of :name, scope: :place_id, message: "すでに登録されています"
end
