# frozen_string_literal: true

module PagSeguro
  module Calls
    class Base
      private
      def execute_post
        response = {} #Implementação da requisição POST para o serviço do pagseguro

        response[:code] = [200, 201, 400, 500].sample
        response[:body] = body_response(response[:code])
        response
      end

      def body_response(code)
        case code
        when 200, 201
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
