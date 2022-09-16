# frozen_string_literal: true

class AnswersNotificationJob < ApplicationJob
  queue_as :default

  def perform(answer)
    AnswersNotification.new.send_answer(answer)
  end
end
