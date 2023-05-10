class Category < ApplicationRecord
  has_many :payee_categories, dependent: :destroy
  has_many :payees, through: :payee_categories
end
