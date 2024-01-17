class Api::V1::UserAssesmentsController < ApiController
  load_and_authorize_resource 

  def index
    @user_assesments_attended = UserAssesment.user_assesment_attempted(current_user.id , true)
    @user_assesments_not_attended = UserAssesment.user_assesment_attempted(current_user.id , false)
  end

  def create
    @user_assesment = UserAssesment.new(user_assesment_params)

    if @user_assesment.save
      render json: @user_assesment
    else
      render_error_response(@user_assesment.errors.full_messages, :unprocessable_entity)
    end
  end


  def update
    @user_assesment = UserAssesment.find(params[:id])
    if @user_assesment.update(user_assesment_params)
      @user_assesment
    else
      render_error_response(@user_assesment.errors.full_messages, :unprocessable_entity)
    end
  end

  def destroy
    @user_assesment = UserAssesment.find(params[:id])
    if @user_assesment.destroy
      render json: { status: 'success', message: 'UserAssesment deleted successfully' }
    else
      render_error_response(@user_assesment.errors.full_messages, :unprocessable_entity)
    end
  end

  private
  def user_assesment_params
    params.require(:user_assesment).permit(:user_id, :assesment_id)
  end

  def render_error_response(message, status)
    render json: { data: message, status: 'failed' }, status: status
  end
end




