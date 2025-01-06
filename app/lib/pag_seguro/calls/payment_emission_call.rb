# frozen_string_literal: true

module PagSeguro
  module Calls
    class PaymentEmissionCall < Base
      def initialize(params)
        @params = params
      end

      def call
        execute_post
      end

      private

      def url
        "#{api_url}/v1/payment?ref=#{payload[:payment_id]}" #url de comunicação com o serviço do pagseguro
      end

      def payload
        @params.except(:provider)
      end
    end
  end
end
