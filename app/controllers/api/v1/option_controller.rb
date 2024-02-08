class OptionController < ApiController 
  def create(question_id)
    @option = Option.new(option_params)
    @option.question_id = question_id
    @option.save!
  end

  private 

  def option_params
    permit(:option).require(:option , :description , :is_correct)
  end
end