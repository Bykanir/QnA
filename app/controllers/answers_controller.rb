class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def index; end

  def new; end

  def create
    @answer = question.answers.create(answer_params)

    if @answer.save
      redirect_to question
    else
      render :new
    end
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  helper_method :question

  def answer_params
    params.require(:answer).permit(:body)
  end
end
