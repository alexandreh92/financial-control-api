module Importers
  class Ofx < Base
    def import!
      raise 'Bank not supported' if importer.blank?

      importer.new(data: parsed_ofx).import!
    end

    private

    def parsed_ofx
      @parsed_ofx ||= OfxParser::OfxParser.parse(File.open(file))
    end

    def bank_id
      parsed_ofx.sign_on.institute.id
    end

    def importer
      @importer ||= Dictionary::REGISTERED_IMPORTERS[bank_id.to_sym]
    end
  end
end
