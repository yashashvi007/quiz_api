class Api::V1::AssesmentsController < ApiController
  load_and_authorize_resource only: [:index, :show, :create]

  include Pagy::Backend

  def index  
      data = Assesment.includes(:questions).all 
      @pagy, @assesments = pagy(data, items: params[:per_page] , page: params[:page] || 1)
      @pagination = pagy_metadata(@pagy)
  end

  def show
    @assesment = Assesment.find(params[:id])
  end

  def create
    @assesment = Assesment.new(assesment_params)
    @assesment.user_id = current_user.id

    begin
      @assesment.save!
    rescue StandardError => e
      render_error_response(e.message, :unprocessable_entity)
    end
  end

  def update
    begin
      @assesment = Assesment.find!(params[:id])
      @assesment.update!(assesment_params)
    rescue ActiveRecord::RecordNotFound
      render_error_response("Assessment not found", :not_found)
    rescue StandardError => e
      render_error_response(e.message, :unprocessable_entity)
    end
  end

  def destroy
    @assesment = Assesment.find_by(id: params[:id])

    if @assesment.nil?
      render_error_response("Assessment not found", :not_found)
    else
      begin
        @assesment.destroy!
        head :no_content
      rescue StandardError => e
        render_error_response(e.message, :unprocessable_entity)
      end
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
