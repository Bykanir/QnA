class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    @answer = question.answers.create(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to question
    else
      render 'questions/show'
    end
  end

  def destroy
    if current_user == answer.author
      answer.destroy
    redirect_to question_path(question), alert: 'Your answer successfully deleted.'
    else
      render 'questions/show', alert: 'You are not the author of this answer.'
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

  def answer
    @answer ||= Answer.find(params[:id])
  end

end
