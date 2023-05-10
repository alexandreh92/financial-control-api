class Bank < ApplicationRecord
  has_many :accounts, dependent: :destroy
end
