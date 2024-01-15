class AnswersService  
  def initialize(user , params)
    @user = user 
    @params = params 
  end 
   
  def calculate_score
    improvement_tags = []
    correct = 0 
    wrong = 0
    @params[:answers].each do |res|
      question = Question.find res[:question_id]  
      correct_answer = question.options.where(is_correct:true).pluck(:id)
     
      if correct_answer == res[:options_choosen]
        correct += 1 
      else 
        wrong += 1 
      end
      res = Response.new(assesment_id: @params[:assesment_id], question_id: res[:question_id], user_id: @user.id ,  option: res[:options_choosen])
      res.save
     
    end
    return wrong,correct,improvement_tags
  end   

  def mark_attended_true(correct)
    user_assesment =  UserAssesment.find_by(user_id: @user.id , assesment_id: @params[:assesment_id])
    user_assesment.attended = true 
    user_assesment.score = correct
    user_assesment.save
  end
end 