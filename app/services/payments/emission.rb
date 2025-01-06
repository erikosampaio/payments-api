module Payments
  class Emission
    def initialize(payment, params)
      @payment = payment
      @params = params
      @messages = []
    end

    def call
      [:pag_seguro, :mercado_pago].each do |provider|
        orchestrator = Orchestrators::Payment::EmissionOrchestrator.new(@params.merge(provider: provider))
        result = orchestrator.call

        if result[:success]
          @payment.update!(status: :paid)
          return { success: true, message: "Payment created successfully with #{provider.to_s.humanize}.", data: result[:data] }
        else
          @messages << "Error with #{provider.to_s.humanize}: #{result[:errors]}"
        end
      end

      { success: false, message: @messages.join(' ') }
    end
  end
end
