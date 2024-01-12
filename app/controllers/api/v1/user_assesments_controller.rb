class Api::V1::UserAssesmentsController < ApiController 
  def index
    @user_assesments_attended = UserAssesment.includes(:assesment).where(user_id: current_user.id).and(UserAssesment.where(attended: true))
    @user_assesments_not_attended = UserAssesment.includes(:assesment).where(user_id: current_user.id).and(UserAssesment.where(attended: false))
  end

  def create
      @user_assesment = UserAssesment.new(user_id: params[:user_id] , assesment_id: params[:assesment_id])
      if @user_assesment.save 
        @user_assesment
      else 
        render json: {
          data: @user_assesment.errors.full_messages,  
          status: "failed" 
        }, status: :unprocessable_entity 
      end  
  end
end  




