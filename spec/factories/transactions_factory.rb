FactoryBot.define do
  factory :transaction do
    external_id { "MyString" }
    memo { "MyString" }
    payee { nil }
    type { 1 }
    date { "2023-03-02" }
  end
end
