class Api::V1::AnswersController < ApiController 

  def create 
    assesment = Assesment.find_by(id: params[:assesment_id])
  
    if !UserAssesment.user_assesment_already_finished(current_user.id , params[:assesment_id] , true).empty?
      render json: {
        message: "You have already finished"
      }, status: :unprocessable_entity
    elsif Time.current.utc > assesment.scheduled_at.utc && Time.current.utc < assesment.end_time.utc
      answer_service = AnswersService.new(current_user , params)
      wrong,correct,improvement_tags = answer_service.calculate_score
      answer_service.mark_attended_true(correct)
      render json: {
         improvement_tags: improvement_tags.flatten.uniq,
         wrong: wrong,
         correct: correct
      }
    else
      render json: {
        message: "Assesment is either over or not started yet"
      }, status: :unprocessable_entity
    end
  end
end