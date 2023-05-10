FactoryBot.define do
  factory :transaction do
    account
    payee

    external_id { 'ExternalId' }
    amount { 10.0 }
    memo { 'MyString' }
    transaction_type { 1 }
    date { '2023-03-02' }

    trait :credit do
      amount { 15.0 }
      transaction_type { Enums::TransactionType::CREDIT }
    end

    trait :debit do
      amount { -10 }
      transaction_type { Enums::TransactionType::DEBIT }
    end
  end
end
