class Category < ApplicationRecord
  has_many :categories_owned_by_shop
end
