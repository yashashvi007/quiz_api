class Api::V1::QuestionsController < ApiController 
  load_and_authorize_resource only: [:index, :update, :create,:destroy]
  before_action :set_assesment, only: [:index , :show]

  include Pagy::Backend

  def index 
    #  items_per_page = 5
     data = @assesment.questions.includes(:options).all
     @pagy, @questions  = pagy(data, items: params[:per_page] , page: params[:page] || 1)
     @pagination = pagy_metadata(@pagy)
  end

  def create 
    @question = Question.create!(text: params[:question][:text], assesment_id: params[:assesment_id] )
    create_options(params[:question][:options], @question) if @question.valid?  
  end  

  # def create
  #   @question = Question.new(question_params)

  #   if @question.save
  #     params[:question][:options].each do |option| 
        
  #     end
  #   end
  # end

  def show
    @question = Question.includes(:options).find(id: params[:id])
  end

 

  def destroy
      @question = Question.find_by(id: params[:id])
      
      if @question.destroy
        render json: { message: 'Question deleted successfully' }, status: :ok
      else
        render json: { error: 'Unable to delete the question' }, status: :unprocessable_entity
      end
  end

  private 
  def set_assesment
    @assesment = Assesment.find_by(id: params[:assesment_id])
  end

  def question_params
    params.require(:question).permit(:text)
  end

  def create_options(options_params, question)
    options_params.each do |option_params|
      option = Option.new(option_params.permit(:option, :description, :is_correct))
      option.question = question
      option.save
    end
  end
end