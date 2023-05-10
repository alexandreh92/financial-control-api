module Importers
  module Nubank
    class AccountImporter < NubankImporter
      attr_reader :bank

      def initialize(opts = {})
        @bank = opts[:bank]
        super(opts)
      end

      def import!
        return account unless account.new_record?

        account.bank = bank
        account.save!

        account
      end

      private

      def account
        @account ||= Account.find_or_initialize_by(number: account_data.number)
      end

      def account_data
        @account_data ||= data.bank_account
      end
    end
  end
end
