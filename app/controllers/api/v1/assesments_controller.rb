class Api::V1::AssesmentsController < ApiController 
  load_and_authorize_resource

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_destroyed
  rescue_from ActiveRecord::RecordInvalid , with: :handle_record_invalid
  rescue_from ActiveRecord::RecordNotFound , with: :handle_record_not_found

  def index 
    @assessments = Assesment.includes(:questions).all
    # render json: @assessments.as_json(include: { questions: { only: [:id, :text] } }), status: :ok
  end

  def show
    @assesment = Assesment.includes(questions: :options).find(params[:id]) 
    render json: @assesment.as_json(
        include: { 
            questions: { 
              only: [:id, :text] , 
              include: {
                options: {
                  only: [:id, :option]
                }
              }
            } 
          }
        ), status: :ok
  end

  
  def create
    @assesment = Assesment.new(assesment_params)
    @assesment.user_id = current_user.id   

    if @assesment.save!  
      render json: @assesment, status: :ok
    else 
      render json: {
        data: @assesment.errors.full_messages, 
        status: "failed"
      }, status: :unprocessable_entity
    end 
  end  


  def update
    @assesment = Assesment.find(params[:id])
    if @assesment.update(assesment_params)
      render json: @assesment, status: :ok
    else 
      render json: {
        data: @assesment.errors.full_messages, 
        status: "failed"
      }, status: :unprocessable_entity
    end 
  end

  def destroy
    @assesment = Assesment.find!(params[:id]) 
    @assesment.destroy!  
    head :no_content
  end


  private  
  def assesment_params 
    params.require(:assesment).permit(:title, :duration, :difficulty_level, :is_archived, :scheduled_at, :end_time)
  end

  def handle_record_not_destroyed(exception)
    render json: { message: exception.message }, status: :unprocessable_entity
  end

  def handle_record_invalid
    render json: { message: exception.message }, status: :unprocessable_entity
  end

  def handle_record_not_found
    render json: { message: exception.message }, status: :not_found
  end


end 