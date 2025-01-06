# frozen_string_literal: true

module Integrations
  module MercadoPago
    module Payment
      class Emission < Base
        def mercado_pago_call
          ::MercadoPago::Calls::PaymentEmissionCall
        end
      end
    end
  end
end
