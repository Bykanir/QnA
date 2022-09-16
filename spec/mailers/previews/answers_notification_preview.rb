# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/answers_notification
class AnswersNotificationPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/answers_notification/notification
  def notification
    AnswersNotificationMailer.notification
  end
end
