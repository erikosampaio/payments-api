# frozen_string_literal: true

module Orchestrators
  module Payment
    class Base
      def initialize(params)
        @params = params
      end

      def call
        integration = select_integration(@params[:provider])

        return { success: false, errors: 'Invalid provider' } unless integration

        integration.new(@params).call
      end

      private

      def select_integration(provider)
        raise(NotImplementedError)
      end
    end
  end
end
