# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersNotification do
  let(:subscribers) { create_list(:user, 3) }
  let(:question) { create(:question, author: subscribers.first) }
  let(:answer) { create(:answer, question: question, author: subscribers[1]) }

  it 'sends answers notification to author' do
    expect(AnswersNotificationMailer).to receive(:notification).with(subscribers.first, answer).and_call_original

    subject.send_answer(answer)
  end

  it 'sends answer notification for all subscribers' do
    question.subscribe(subscribers[1])
    question.subscribe(subscribers[2])

    subscribers.each do |user|
      expect(AnswersNotificationMailer).to receive(:notification).with(user, answer).and_call_original
    end

    subject.send_answer(answer)
  end
end
