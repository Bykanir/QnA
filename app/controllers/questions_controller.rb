# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :gon_question_id, only: %i[show]

  after_action :publish_question, only: [:create]
  
  include Voted

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answer.links.new
  end

  def new
    question.links.new
    question.reward ||= Reward.new
  end

  def edit; end

  def create
    @question = Question.new(question_params)
    question.author = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    question.update(question_params)
  end

  def destroy
    if current_user.author_of?(question)
      question.destroy
      redirect_to questions_path, notice: 'Your question successfully deleted.'
    else
      render 'questions/show', alert: 'You are not the author of this question.'
    end
  end

  private

  def question
    @question ||= params[:id] ? Question.with_attached_files.find(params[:id]) : Question.new
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                                    links_attributes: %i[name url],
                                                    reward_attributes: %i[title image])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      "questions_", 
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end

  def gon_question_id
    gon.question_id = question.id if question
  end
  
end
