class PayeeCategory < ApplicationRecord
  belongs_to :payee
  belongs_to :category
end
