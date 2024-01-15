class Api::V1::TagsController < ApiController
  load_and_authorize_resource

  before_action :find_question, only: [:index, :create]

  def index
    @tags = @question.tags
    render json: { data: @question.tags }
  end

  def show
    render json: { tag: find_tag }
  end
  
  def create
    params[:tags].each do |tag_params|
      tag = Tag.create(tag_params.permit(:title))
      @question.tags << tag
    end 
    
    render json: { question: @question, tags: @question.tags }
  end

  def update
    
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_tag
    Tag.find(params[:id])
  end


end
