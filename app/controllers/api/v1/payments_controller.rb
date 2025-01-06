module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :set_payment, only: [:show]

      # GET /payments
      def index
        render json: {
          data: Payment.order(created_at: :desc).map { |payment|
            PaymentSerializer.new(payment).serializable_hash[:data][:attributes]
          }
        }
      end

      # GET /payments/1
      def show
        render json: {
          data: PaymentSerializer.new(@payment).serializable_hash[:data][:attributes]
        }
      end

      # POST /payments
      def create
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
