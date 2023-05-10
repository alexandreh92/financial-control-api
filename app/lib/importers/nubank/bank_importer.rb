module Importers
  module Nubank
    class BankImporter < NubankImporter
      def import!
        return bank unless bank.new_record?

        bank.name = bank_data.name
        bank.save!

        bank
      end

      private

        def bank
          @bank ||= ::Bank.find_or_initialize_by(external_id: bank_data.id)
        end

        def bank_data
          @bank_data ||= data.sign_on.institute
        end
    end
  end
end
