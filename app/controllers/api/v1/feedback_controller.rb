class Api::V1::FeedbackController < ApiController 
  def index
    feedbackServices =  FeedbackService.new(params[:assesment_id] , current_user)
    res =  feedbackServices.give_feedback
    render json: {
      res: res
    }
  end
end  

