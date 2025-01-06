module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :set_payment, only: [:show]

      # GET /payments
      def index
        render json: { payments: Payment.order(created_at: :desc) }
      end

      # GET /payments/1
      def show
        render json: { payment: @payment }
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
