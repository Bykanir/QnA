# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersNotificationJob, type: :job do
  let(:author) { create(:user) }
  let(:question) { create(:question, author: author) }
  let(:answer) { create(:answer, question: question, author: author) }
  let(:service) { double('AnswersNotification') }

  before do
    allow(AnswersNotification).to receive(:new).and_return(service)
  end

  it 'calls DailyDigest#send_digest' do
    expect(service).to receive(:send_answer).with(answer)
    described_class.perform_now(answer)
  end
end
