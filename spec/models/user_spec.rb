# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).class_name('Answer').with_foreign_key('author_id') }
  it { should have_many(:questions).class_name('Question').with_foreign_key('author_id') }
  it { should have_many(:rewards) }
  it { should have_many(:votes) }
  it { should have_many(:authorizations).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'author_of?' do
    let(:author) { create(:user) }
    let(:user) { create(:user) }
    let(:question) { create(:question, author: author) }
    let(:reward) { create(:reward, question: question) }

    it 'user author' do
      question = create(:question, author: author)

      expect(author).to be_author_of(question)
    end

    it 'user not author' do
      question = create(:question, author: author)

      expect(user).to_not be_author_of(question)
    end

    it 'user awarding' do
      user.awarding(reward)

      expect(reward).to eq user.rewards.first
    end
  end

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth)  { OmniAuth::AuthHash.new(provider: 'facebook', uid: '1234567') }
    let(:service) { double('service FindForOauth') }

    it 'calls service FindForOauth' do
      expect(FindForOauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end
end
