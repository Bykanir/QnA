require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).class_name('Answer').with_foreign_key('author_id') }
  it { should have_many(:questions).class_name('Question').with_foreign_key('author_id') }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'author_of?' do
    let(:author) { create(:user) }
    let(:user) { create(:user) }

    it 'user author' do
      question = create(:question, author: author)
      
      expect(author).to be_author_of(question)
    end
    
    it 'user not author' do
      question = create(:question, author: author)
      
      expect(user).to_not be_author_of(question)
    end
  end
  
end
