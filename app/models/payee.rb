class Payee < ApplicationRecord
  has_many :payee_categories, dependent: :destroy
  has_many :categories, through: :payee_categories
end
