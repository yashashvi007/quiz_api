class Api::V1::UserAssesmentsController < ApiController 
  def index
    @user_assesments = UserAssesment.includes(:assesment).where(user_id: current_user.id)

    render json: {
      user_assesments: @user_assesments.as_json(include: { assesment: { only: [:id, :duration , :difficulty_level] } })
    }
  end

  def create
    already_assigned = UserAssesment.where(user_id: current_user.id).and(UserAssesment.where(assesment_id: params[:assesment_id])) 
  
    if !already_assigned.empty?
      render json: {
        status: "already assigned"
      }, status: :unprocessable_entity
    else   
      @user_assesment = UserAssesment.new(user_id: params[:user_id] , assesment_id: params[:assesment_id])

      if @user_assesment.save 
        render json: @user_assesment, status: :ok
      else 
        render json: {
          data: @user_assesment.errors.full_messages, 
          status: "failed"
        }, status: :unprocessable_entity
      end  
    end 
  
   
  end

  # private 

  # def user_assesment_params 
  #   params.require(:user_assesment).permit(:user_id , :assesment_id)
  # end

end  




