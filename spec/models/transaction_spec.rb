require 'rails_helper'

RSpec.describe Transaction do
  subject(:model) { create(:transaction) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:payee) }

  it { is_expected.to have_many(:categories).through(:payee) }

  describe '#total_spent_per_category' do
    let!(:account) { create(:account) }
    let!(:supermarket_category) { create(:category, name: 'Supermarket') }
    let!(:gas_category) { create(:category, name: 'Gasoline') }
    let!(:payment_category) { create(:category, name: 'Payment') }

    let!(:supermarket_payee) { create(:payee, name: 'Foo Grocery', categories: [supermarket_category]) }
    let!(:gas_payee) { create(:payee, name: 'Baz Gas Station', categories: [gas_category]) }
    let!(:payment_payee) { create(:payee, name: 'My Work Place', categories: [payment_category]) }

    let!(:supermarket_transaction) do
      create(:transaction, :debit, amount: -50.0, payee: supermarket_payee, account: account, external_id: '1')
    end
    let!(:gas_transaction) do
      create(:transaction, :debit, amount: -30.0, payee: gas_payee, account: account, external_id: '2')
    end
    let!(:payment_transaction) do
      create(:transaction, :credit, amount: 100.0, payee: payment_payee, account: account, external_id: '3')
    end

    it 'returns value spent on each category' do
      expect(described_class.total_spent_per_category).to eq(
        {
          [supermarket_category.id, supermarket_category.name] => -50,
          [gas_category.id, gas_category.name] => -30
        }
      )
    end
  end
end
