class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  before_action :authenticate

  private

  def authenticate
    authenticate_user_with_token || handle_invalid_credentials
  end

  def authenticate_user_with_token
    authenticate_with_http_token do |token, options|
      @api_key ||= ApiKey.find_by!(token: token)
    end
  end

  def handle_invalid_credentials
    render json: { message: "Invalid credentials" }, status: :unauthorized
  end

  def handle_not_found
    render json: { message: "Api key not found" }, status: :not_found
  end
end
