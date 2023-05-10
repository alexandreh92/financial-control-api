class Payee < ApplicationRecord
  # Associations
  has_many :payee_categories, dependent: :destroy
  has_many :categories, through: :payee_categories

  # Validations
  validates :name, presence: true, uniqueness: true
end
