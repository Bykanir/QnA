# frozen_string_literal: true

class DailyDigestMailer < ApplicationMailer
  def digest(user)
    @questions_list = Question.where('created_at > ?', 1.day.ago)

    mail to: user.email
  end
end
