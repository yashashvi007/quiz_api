class Api::V1::AssesmentsController < ApiController 
  

  def index
    @assessments = Assesment.includes(:questions).all
    render json: @assessments.as_json(include: { questions: { only: [:id, :text] } }), status: :ok
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

    if @assesment.save  
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
    @assesment = Assesment.find(params[:id]) 
    @assesment.destroy  
    render json: {
      status: "successfull" 
    }
  end


  private  
  def assesment_params 
    params.require(:assesment).permit(:title, :duration, :difficulty_level, :is_archived)
  end

end 