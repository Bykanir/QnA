class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:create]
  before_action :answer, only: [:update, :best]

  def create
    @answer = question.answers.create(answer_params.merge(author: current_user))
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    if current_user.author_of?(answer)
      answer.destroy
      flash[:notice] = 'Your answer successfully deleted.'
      @question = @answer.question
    end
  end

  def best
    @answer.mark_as_best if current_user.author_of?(question)
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  helper_method :question

  def answer_params
    params.require(:answer).permit(:body, files:[])
  end

  def answer
    @answer ||= Answer.with_attached_files.find(params[:id])
  end

end
