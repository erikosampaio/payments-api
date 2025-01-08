# frozen_string_literal: true

module MercadoPago
  module Calls
    class Base
      private
      def execute_post
        response = {} # Request to API real

        response[:code] = @params[:cvc].blank? ? 400 : 201
        response[:body] = body_response(response[:code])
        response
      end

      def body_response(code)
        case code
        when 201
          "Código da transação: #{SecureRandom.uuid}"
        else
          Faker::Lorem.sentence
        end
      end

      def payload
        raise(NotImplementedError)
      end
    end
  end
end
