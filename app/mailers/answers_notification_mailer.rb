# frozen_string_literal: true

class AnswersNotificationMailer < ApplicationMailer
  def notification(user, answer)
    @answer = answer
    @question = answer.question

    mail to: user.email
  end
end
