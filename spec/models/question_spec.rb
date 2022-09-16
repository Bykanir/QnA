# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  it { should have_one(:reward).dependent(:destroy) }
  it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
  it { should have_many(:subscribers).through(:subscriptions).source(:user) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }
  it { should accept_nested_attributes_for :reward }

  it 'have many attached files' do
    expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  describe 'reputation' do
    let(:author) { create(:user) }
    let(:question) { build(:question, author: author) }

    it 'calls ReputationJob' do
      expect(ReputationJob).to receive(:perform_later).with(question)
      question.save!
    end
  end

  describe 'subscribe' do
    let(:author) { create(:user) }
    let(:user) { create(:user) }
    let(:question) { create(:question, author: author) }

    it 'after create question the author automatically subscribes' do
      expect(question.subscribers).to include author
    end

    it 'subscribe other user' do
      question.subscribe(user)

      expect(question.subscribers).to include user
    end
  end

  describe 'unsubscribe' do
    let(:author) { create(:user) }
    let(:user) { create(:user) }
    let(:question) { create(:question, author: author) }

    before { question.subscribe(user) }

    it 'unsubscribe from question' do
      question.unsubscribe(user)

      expect(question.subscribers).to_not include user
    end
  end
end
