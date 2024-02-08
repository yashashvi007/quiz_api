class Api::V1::AssesmentsController < ApiController
  load_and_authorize_resource only: [:index, :show, :update , :create , :destroy]

  include Pagy::Backend

  def index  
    data = Assesment.includes(:questions).where(is_archived: false)
    @pagy, @assesments = pagy(data, items: params[:per_page] , page: params[:page] || 1)
    @pagination = pagy_metadata(@pagy)
  end

  def show
    @assesment = Assesment.find_by!(id: params[:id])
    render json: {
      assesment: @assesment
    } , status: :ok
  end

  def create
    @assesment = Assesment.new(assesment_params)
    @assesment.user_id = current_user.id
    if @assesment.save!
      render json: {
        assesment: @assesment
      } , status: :created
    else 
      render json: {
        message: "creation failed"
      } , status: :unprocessable_entity
    end
  end

  def update
    @assesment = Assesment.find(params[:id])
    if @assesment.update(assesment_params)
      render json: {
        assesment: @assesment
      }, status: :ok
    else 
      render json: {
        message: "Updated successfully"
      } , status: :unprocessable_entity
    end 
  end

  def destroy
    @assesment = Assesment.find_by(id: params[:id])
    @assesment&.is_archived = true
    
    if @assesment.save(validate: false)
      @assesment
    else
      render_error_response("Assessment not found", :not_found)
    end
  end

  private
  def assesment_params
    params.require(:assesment).permit(:title, :duration, :difficulty_level, :is_archived, :scheduled_at, :end_time)
  end

  def render_error_response(message, status)
    render json: { error: message, status: "failed" }, status: status
  end
end