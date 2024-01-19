# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json  

  before_action :configure_permitted_parameters, if: :devise_controller?
 
  private  
  def respond_with(resource, options={})
    if resource.persisted? 
      UserMailer.welcome_email(resource).deliver_later
      render json: {
        status: {code: 200, 
                  message: 'Signed up successfully',
                  data: UserSerializer.new(resource).serializable_hash[:data][:attributes]}
      }, status: :ok  
    else 
      render json: {
        status: {message: 'User could not be created successfully', 
          errors: resource.errors.full_messages, 
          status: :unprocessable_entity 
        }  
      }  
    end  
  end 

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
  end
end