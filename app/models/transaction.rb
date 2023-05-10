class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :payee

  has_many :categories, through: :payee

  scope :amount_grouped_per_category, lambda {
    category_table = Category.arel_table

    joins(:categories)
      .select(category_table[:id], category_table[:name])
      .group(category_table[:id], category_table[:name])
      .sum(:amount)
  }
end
