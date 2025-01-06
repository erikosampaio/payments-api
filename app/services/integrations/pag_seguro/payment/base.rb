# frozen_string_literal: true

module Integrations
  module PagSeguro
    module Payment
      class Base
        def initialize(params)
          @params = params
        end

        def call
          response = pag_seguro_call.new(params).call
          parsed_response = JSON.parse(response.to_json, symbolize_names: true)

          return { success: true, data: parsed_response[:body] } if [200, 201, 202].include?(response[:code])

          { success: false, errors: parsed_response[:body] }
        rescue StandardError => e
          Rails.logger.error(e.message)
          { success: false, errors: e.message }
        end

        private
        attr_reader :params

        private def pag_seguro_call
          raise(NotImplementedError)
        end
      end
    end
  end
end
