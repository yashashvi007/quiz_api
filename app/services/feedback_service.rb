class FeedbackService

  def initialize(assesment_id , current_user)
    @current_user = current_user 
    @assesment_id = assesment_id 
    
    @user_assesments = UserAssesment.user_assesment_already_finished(current_user.id , assesment_id , true)
  end

  def give_feedback 
    res = [] 
    responses =  Response.user_response_for_assesment(@current_user.id , @assesment_id)
  
    responses.each do |response| 
      question = response.question  
      x = {} 
      x[:question] = question 
      x[:correct_answer] = Option.find(question.options.where(is_correct: true).pluck(:id))
      x[:your_response] = Option.find(eval(response.option))
      res.push(x)  
    end  

    return res 
  end 

end 

