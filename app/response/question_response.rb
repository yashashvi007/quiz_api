class QuestionResponse
  def initialize(question, options)
    @question = question
    @options = options
  end

  def response
    json: {
      question: @question,
      options: @options
    }
  end
end