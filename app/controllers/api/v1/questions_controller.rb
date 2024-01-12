class Api::V1::QuestionsController < ApiController 

  before_action :set_assesment, only: [:index , :show]

  def index 
     @questions = @assesment.questions.includes(:options)
  end

  
  def create 
    @question = Question.create(text: params[:question][:text], assesment_id: params[:assesment_id] )
    options = params[:question][:options].each_with_index do |option ,index| 
      @option = Option.new(option: option[:option], description: option[:description], question_id: @question.id , is_correct: option[:is_correct])
      @option.save 
    end  
  end

  def show
    @question = Question.includes(:options).find(params[:id])
  end

  private 
  def set_assesment
    @assesment = Assesment.find_by(id: params[:assesment_id])
  end
end