# frozen_string_literal: true

module Orchestrators
  module Payment
    class EmissionOrchestrator < Base
      private

      def select_integration(provider)
        case provider
        when :pag_seguro
          Integrations::PagSeguro::Payment::Emission
        when :mercado_pago
          Integrations::MercadoPago::Payment::Emission
        end
      end
    end
  end
end
