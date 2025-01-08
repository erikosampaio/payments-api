# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix

  respond_to :json

  private
  def respond_with(current_user, _opts = {})
    render json: {
      status: {
        code: 200, message: 'Logged in successfully.',
        data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    authorization_header = request.headers['Authorization']

    if authorization_header.nil?
      render json: { message: "Couldn't find an active session." }, status: :unauthorized
      return
    end

    begin
      jwt_payload = JWT.decode(authorization_header.split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
      sign_out(current_user)
      render json: { message: 'Logged out successfully.' }, status: :ok
    rescue JWT::DecodeError, JWT::VerificationError
      render json: { message: "Couldn't find an active session." }, status: :unauthorized
    end
  end
end
