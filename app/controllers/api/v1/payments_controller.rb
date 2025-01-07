module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :set_payment, only: [:show]

      # GET /payments
      def index
        payments = Payment.order(created_at: :desc).map { |payment|
          PaymentSerializer.new(payment).serializable_hash[:data][:attributes]
        }

        render(json: { data: payments }, status: :ok)
      end

      # GET /payments/1
      def show
        render(json: { data: PaymentSerializer.new(@payment).serializable_hash[:data][:attributes] }, status: :ok)
      end

      # POST /payments
      def create
        @payment = Payment.new(permitted_params.merge(status: :pending))

        if @payment.save
          result = Payments::Emission.new(@payment, permitted_params).call

          if result[:success]
            render(json: { message: result[:message], data: result[:data] }, status: :created)
            return
          end

          render(json: { message: result[:message] }, status: :unprocessable_entity)
          return
        end

        render(json: { message: @payment.errors.full_messages.to_sentence }, status: :unprocessable_entity)
      end

      private
      def set_payment
        @payment = Payment.find(params[:id])
      end

      def permitted_params
        params.require(:payment).permit(:name, :number, :due_date, :cvc, :amount)
      end
    end
  end
end
