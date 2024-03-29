# frozen_string_literal: true

class AnswersChannel < ApplicationCable::Channel
  def follow
    stream_from "question_#{params[:question_id]}_answers"
  end
end
