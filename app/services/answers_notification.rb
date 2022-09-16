# frozen_string_literal: true

class AnswersNotification
  def send_answer(answer)
    answer.question.subscribers.find_each do |user|
      AnswersNotificationMailer.notification(user, answer).deliver_later
    end
  end
end
