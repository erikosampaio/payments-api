# frozen_string_literal: true

module Integrations
  module PagSeguro
    module Payment
      class Emission < Base
        def pag_seguro_call
          ::PagSeguro::Calls::PaymentEmissionCall
        end
      end
    end
  end
end
