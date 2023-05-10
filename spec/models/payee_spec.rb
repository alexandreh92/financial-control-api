require 'rails_helper'

RSpec.describe Payee do
  subject(:model) { create(:payee) }

  it { is_expected.to have_many(:payee_categories).dependent(:destroy) }
  it { is_expected.to have_many(:categories).through(:payee_categories) }

  it { is_expected.to validate_uniqueness_of(:name) }
end
