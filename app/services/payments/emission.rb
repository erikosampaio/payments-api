module Payments
  class Emission
    def initialize(payment, providers)
      @payment = payment
      @providers = providers
      @messages = []
    end

    def call
      @providers.each do |provider|
        orchestrator = Orchestrators::Payment::EmissionOrchestrator.new(params.merge(provider: provider))
        result = orchestrator.call

        if result[:success]
          @payment.update!(status: :paid)
          return { success: true, message: "Payment created successfully with #{provider.to_s.humanize}.", data: result[:data] }
        else
          @messages << "Error with provider #{provider.to_s.humanize}: #{result[:errors]}"
        end
      end

      { success: false, message: @messages.join(' ') }
    end

    private
    def params
      @payment.attributes.slice('name', 'number', 'due_date', 'cvc', 'amount').transform_keys(&:to_sym)
    end
  end
end
