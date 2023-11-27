class Api::V1::AnswersController < ApiController 
  before_action :find_question 
  before_action :find_answer

  def create
    already_responded = Response.where(assesment_id: params[:assesment_id]).and(Response.where(question_id: params[:question_id])).and(Response.where(user_id: current_user.id))

    if already_responded 
      render json: {
        status: "already responded"
      } , status: :ok
    

    elsif @answer == params[:choosen_option]
      response = Response.new(assesment_id: params[:assesment_id], question_id: params[:question_id], user_id: current_user.id , is_correct: true, option: params[:answer][:choosen_option])
      if response.save!
        render json: {
          status:  "saved", 
          response: response
        }, status: :ok
      else    
        render json: {
          errors: response.errors.full_messages
        } , status: :unprocessable_entity
      end 
    else 
      response = Response.create(assesment_id: params[:assesment_id], question_id: params[:question_id], user_id: current_user.id, is_correct: false, option: params[:answer][:choosen_option])
      render json: {
        status:  "wrong" , 
        response: response
      }, status: :unprocessable_entity
    end 
  end

  private 
  def find_question 
    assesment = Assesment.find_by(id: params[:assesment_id])
    @question =  assesment.questions.find(params[:question_id])
  end  

  def find_answer 
    @answer =  @question.correct_answer
  end

end 