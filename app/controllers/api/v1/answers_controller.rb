class Api::V1::AnswersController < ApiController 

  def create
    return unless UserAssesment.where(["user_id = ? and assesment_id = ? and attended = ?", current_user.id, params[:assesment_id] , true]).nil?
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


