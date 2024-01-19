module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    rescue_from StandardError, with: :handle_standard_error
    rescue_from CanCan::AccessDenied, with: :handle_permission_denied
    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: e.message
    end
  end

  private

  def handle_permission_denied(exception)
      render json: {message: exception.message , status: 'authorization_denied'}, status: :unauthorized
  end

  def handle_record_not_found(exception)
    render json: { message: exception.message }, status: :not_found
  end

  def handle_standard_error(exception) 
    render json: { error: 'Internal Server Error', message: exception.to_s }, status: :internal_server_error
  end
end
