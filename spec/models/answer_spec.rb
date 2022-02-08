require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should have_many(:links).dependent(:destroy) }

  it { should belong_to(:question) }
  it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }

  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }

  describe 'mark_as_best' do
    let(:author) { create(:user) }
    let(:question) { create(:question, author: author) }
    let(:answer_1) { create(:answer, question: question, author: author, best: false) }
    let(:answer_2) { create(:answer, question: question, author: author, best: false) }
    let!(:reward) { create(:reward, question: question) }

    before { answer_1.mark_as_best }

    it 'mark answer as best' do
      expect(answer_1).to be_best
    end

    it 're-mark answer as best' do
      answer_2.mark_as_best
      answer_1.reload

      expect(answer_2).to be_best
      expect(answer_1).to_not be_best
    end
  end

  it 'have many attached files' do
    expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)  
  end
  
end
