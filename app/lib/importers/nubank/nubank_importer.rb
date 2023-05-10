module Importers
  module Nubank
    class NubankImporter
      BANK_NAME = 'NUBANK'.freeze

      attr_reader :data

      def initialize(opts = {})
        @data = opts[:data]
      end

      def import!
        bank = BankImporter.new(data: data).import!
        account = AccountImporter.new(data: data, bank: bank).import!
        TransactionsImporter.new(data: data, account: account).import!
      end
    end
  end
end
