require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'save new comment' do
        expect do
          post :create, params: { user_id: user, 
                                  question_id: question,
                                  comment: attributes_for(:comment), 
                                  format: :js }
        end.to change(Comment, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'dont save new comment' do
        expect do
          post :create, params: { user_id: user, 
                                  question_id: question,
                                  comment: attributes_for(:comment, body: nil), 
                                  format: :js }
        end.to_not change(Comment, :count)
      end
    end
  end
end
