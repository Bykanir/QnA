require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let(:service) { double('Services::DailyDigest') }

  before do
    allow(DailyDigest).to receive(:new).and_return()service
  end

  it 'calls '
end
