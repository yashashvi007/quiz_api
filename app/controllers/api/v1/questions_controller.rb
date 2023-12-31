class Api::V1::QuestionsController < ApiController 

  def index 
     @assesment = Assesment.find_by(id: params[:assesment_id])
     @questions = @assesment.questions.includes(:options)
     
     render json: {
       assesment: @assesment , 
       questions: @questions.as_json(
            include: {
              options: {
                only: [:id, :option, :description]
              }
            }
       )
     }
  end

  def create 
    @question = Question.create(text: params[:question][:text], assesment_id: params[:assesment_id] )
    options = params[:question][:options].each_with_index do |option ,index| 
      @option = Option.new(option: option[:option], description: option[:description], question_id: @question.id , is_correct: option[:is_correct])
      @option.save 
    end  

    render json: { 
      question: @question,  
      options: options, 
    }
  end


  def show
    @assesment = Assesment.find_by(id: params[:assesment_id])
    @question = Question.includes(:options).find(params[:id])

    render json: {
        question: @question.as_json(
          include: {
            options: {
              only: [:id, :option, :description]
            }
          }
        )
    }
  end
end