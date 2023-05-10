class Transaction < ApplicationRecord
  # Associations
  belongs_to :account
  belongs_to :payee

  has_many :categories, through: :payee

  enum transaction_type: Enums::TransactionType::VALUES

  validate :amount_greater_than_zero, if: :credit?
  validate :amount_less_than_zero, if: :debit?

  # Scopes

  scope :per_category, lambda {
    category_table = Category.arel_table

    joins(:categories)
      .select(category_table[:id], category_table[:name])
      .group(category_table[:id], category_table[:name])
  }

  scope :total_spent_per_category, lambda {
    where(transaction_type: Enums::TransactionType::DEBIT)
      .per_category
      .sum(:amount)
  }

  scope :total_earnings_per_category, lambda {
    where(transaction_type: Enums::TransactionType::CREDIT)
      .per_category
      .sum(:amount)
  }

  private

    def amount_greater_than_zero
      # TODO
    end

    def amount_less_than_zero
      # TODO
    end
end
