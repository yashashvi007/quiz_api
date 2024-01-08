class Api::V1::AnswersController < ApiController 

  def create
    answer_service = AnswersService.new(current_user , params)
    wrong,correct,improvement_tags = answer_service.calculate_score
    render json: {
      improvement_tags: improvement_tags.flatten.uniq,
      wrong: wrong,
      correct: correct
    }
  end
end 


