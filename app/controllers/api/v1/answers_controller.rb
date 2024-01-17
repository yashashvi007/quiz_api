class Api::V1::AnswersController < ApiController 

  def create 
    if !UserAssesment.user_assesment_already_finished(current_user.id , params[:assesment_id] , true).empty?
       render json: {
         message: "You have already finished"
       }, status: :unprocessable_entity
    else
      answer_service = AnswersService.new(current_user , params)
      wrong,correct,improvement_tags = answer_service.calculate_score
      answer_service.mark_attended_true(correct)
      render json: {
        improvement_tags: improvement_tags.flatten.uniq,
        wrong: wrong,
        correct: correct
      }
    end
  end
end 


