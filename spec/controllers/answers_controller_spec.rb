require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, author: author) }

  describe 'POST #create' do
    before { login(author) }
    
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, author: author) } }.to change(question.answers, :count).by(1)
      end
      
      it 'redirects to show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question: question, author: author) }

    context 'User author of the answer' do
      before { login(author) }

      it 'delete the answer' do
        expect { delete :destroy, params: { question_id: question, id: answer} }.to change(Answer, :count).by(-1)
      end
  
      it 'redirects to show' do
        delete :destroy, params: { question_id: question, id: answer } 
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'User not author of the answer' do
      before { login(user) }

      it 'delete the answer' do
        expect { delete :destroy, params: { question_id: question, id: answer} }.to_not change(Answer, :count)
      end
    end
  end

end