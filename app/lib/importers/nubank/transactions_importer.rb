module Importers
  module Nubank
    class TransactionsImporter < NubankImporter
      attr_reader :account

      CENTS = 100

      TRANSACTION_TYPE = {
        CREDIT: 0,
        DEBIT: 1
      }.freeze

      def initialize(opts = {})
        @account = opts[:account]
        super(opts)
      end

      def import!
        transactions_data.each do |raw_transaction|
          transaction = transaction(raw_transaction)

          next unless transaction.new_record?

          transaction.account = account
          transaction.amount = raw_transaction.amount.to_f * CENTS
          transaction.memo = raw_transaction.memo
          transaction.transaction_type = TRANSACTION_TYPE[raw_transaction.type]
          transaction.payee = payee(raw_transaction)
          transaction.date = raw_transaction.date

          transaction.save!
        end
      end

      private

        def transaction(raw_transaction)
          Transaction.find_or_initialize_by(external_id: raw_transaction.fit_id)
        end

        def payee(raw_transaction)
          Payee.find_or_create_by(name: payee_name_for_transaction(raw_transaction))
        end

        def payee_name_for_transaction(raw_transaction)
          # By default nubank doesn't set payee
          return raw_transaction.payee if raw_transaction.payee.present?

          # We need to get it by the memo field, usually the second string after the
          # first dash.
          _description, name = raw_transaction.memo.split(/-/)

          # Nubank doesn't set memo for credit card bill payments
          payee_name = name || BANK_NAME

          payee_name.squish
        end

        def transactions_data
          @transactions_data ||= data.bank_account.statement.transactions
        end
    end
  end
end
